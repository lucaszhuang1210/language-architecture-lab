import java.io.*;
import java.util.Hashtable;

class Disk {
    static final int NUM_SECTORS = 2048;
    static final int DISK_DELAY = 80;

    StringBuffer sectors[] = new StringBuffer[NUM_SECTORS];

    Disk() {
        for (int i=0; i<NUM_SECTORS; ++i)
            sectors[i] = new StringBuffer();
    }

    void write(int sector, StringBuffer data) {
        try {
            Thread.sleep(DISK_DELAY);
        } catch (InterruptedException e) {
            e.printStackTrace();
        }

        sectors[sector].setLength(0);
        sectors[sector].append(data);
    }

    void read(int sector, StringBuffer data) {
        try {
            Thread.sleep(DISK_DELAY);
        } catch (InterruptedException e) {
            e.printStackTrace();
        }

        data.setLength(0);
        data.append(sectors[sector]);
    }
}


class Printer {
    static final int PRINT_DELAY = 275;
    FileWriter writer;

    Printer(int id) {
        try {
            writer = new FileWriter("PRINTER" + id, true); // true = append mode
        } catch (IOException e) {
            e.printStackTrace();
        }
    }

    void print(StringBuffer data) {
        try {
            Thread.sleep(PRINT_DELAY);
        } catch (InterruptedException e) {
            e.printStackTrace();
        }

        try {
            writer.write(data.toString());
            writer.write("\n");       
            writer.flush();
        } catch (IOException e) {
            e.printStackTrace();
        }
    }
}


class PrintJobThread extends Thread {
    String fileName;

    PrintJobThread(String fileToPrint) {
        this.fileName = fileToPrint;
    }

    public void run() {
        FileInfo f = DirectoryManager.lookup(new StringBuffer(fileName));
        if (f == null) {
            System.out.println("File not found: " + fileName);
            return;
        }

        int printerID = OperatingSystemSimulator.printerManager.request();
        Printer printer = new Printer(printerID);
        Disk diskToRead = DiskManager.disks[f.diskNumber];

        for (int i = 0; i < f.fileLength; i++) {
            int sectorToRead = f.startingSector + i;
            printer.print(diskToRead.sectors[sectorToRead]);
        }
        
        OperatingSystemSimulator.printerManager.release(printerID);
    }
}


class FileInfo
{
    int diskNumber;
    int startingSector;
    int fileLength;
}


class DirectoryManager {
    private static Hashtable<String, FileInfo> T = new Hashtable<String, FileInfo>();

    DirectoryManager() {}

    static void enter(StringBuffer fileName, FileInfo file) {
        T.put(fileName.toString(), file);
    }

    static FileInfo lookup(StringBuffer fileName)
    {
        return T.get(fileName.toString());
    }
}


class ResourceManager {
    boolean isFree[];
    
    ResourceManager(int numberOfItems) {
        isFree = new boolean[numberOfItems];
        for (int i=0; i<isFree.length; ++i)
            isFree[i] = true;
    }

    synchronized int request() {
        while (true) {
            for (int i = 0; i < isFree.length; ++i) {
                if (isFree[i]) {
                    isFree[i] = false;
                    return i;
                }
            }
            try {
                this.wait();
            } catch (InterruptedException e) {
                e.printStackTrace();
            }
        }
    }

    synchronized void release(int index) {
        isFree[index] = true;
        this.notify(); // let a blocked thread run
    }
}


class DiskManager extends ResourceManager {
    static int[] diskOffsets;
    static Disk[] disks;

    DiskManager(int numDisk) {
        super(numDisk);
        diskOffsets = new int[numDisk];
        this.startDisks(numDisk);
    }

    void startDisks(int numDisk) {
        disks = new Disk[numDisk];
        for (int i=0; i<disks.length; ++i)
            disks[i] = new Disk();
    }
    
    static int getNextFreeSectorOnDisk(int diskNumber) {
        return diskOffsets[diskNumber];
    }
    
    static void setNextFreeSectorOnDisk(int diskNumber, int sector) {
        diskOffsets[diskNumber] = sector;
    }
}


class PrinterManager extends ResourceManager {
    PrinterManager(int numPrinters) {
        super(numPrinters);
    }
}


class UserThread extends Thread {
    String fileName;
    String line;

    UserThread(String fileName) {
        this.fileName = fileName;
    }

    void processCommandsIn(BufferedReader inputFile) throws IOException {
        String line;

        while ((line = inputFile.readLine()) != null) {
            String[] args = line.split(" ");
            switch (args[0]) {
                case ".save":
                    try {
                        saveFile(args[1], inputFile);
                    } catch (Exception e) {
                        e.printStackTrace();
                    }
                    break;
                case ".print":
                    printFile(args[1]);
                    break;
                default:
                    System.err.println("Unknown command: " + line);
                    break;
            }
        }
    }

    FileInfo makeFileInfo(int d, int offset, int fileLines) {
        FileInfo info = new FileInfo();
        info.diskNumber = d;
        info.startingSector = offset;
        info.fileLength = fileLines;
        return info;
    }

    void saveFile(String fileName, BufferedReader reader) throws Exception {
        int d = OperatingSystemSimulator.diskManager.request();   // DiskNumber
        int offset = DiskManager.getNextFreeSectorOnDisk(d);
        int fileLines = 0;

        while (true) {
            String line = reader.readLine();
            if (line == null) break;
            if (line.equals(".end")) {
                DirectoryManager.enter(new StringBuffer(fileName), makeFileInfo(d, offset, fileLines));
                break;
            }
            DiskManager.disks[d].write(offset + fileLines, new StringBuffer(line));
            fileLines++;
        }

        DiskManager.setNextFreeSectorOnDisk(d, offset + fileLines);
        OperatingSystemSimulator.diskManager.release(d);
    }

    void printFile(String fileName) {
        PrintJobThread pjt = new PrintJobThread(fileName);
        pjt.start();
        try {
            pjt.join();  // Wait for print job to complete before continuing
        } catch (InterruptedException e) {
            e.printStackTrace();
        }
    }

    public void run() {
        try {
            FileInputStream inputStream = new FileInputStream(fileName);
            BufferedReader myReader = new BufferedReader(new InputStreamReader(inputStream));

            processCommandsIn(myReader);

            myReader.close();
            inputStream.close();
        }
        catch (Exception e) {
            e.printStackTrace();
        }
    }
    
}


public class OperatingSystemSimulator
{
    private static OperatingSystemSimulator instance;

    static UserThread[] users;
    static DiskManager diskManager;
    static PrinterManager printerManager;

    private OperatingSystemSimulator(int numUsers, int numDisks, int numPrinters) 
    {
        users = new UserThread[numUsers];
        diskManager = new DiskManager(numDisks);
        printerManager = new PrinterManager(numPrinters);
    }

    static OperatingSystemSimulator getInstance(int numUsers, int numDisks, int numPrinters) {
        if (instance == null) { 
            instance = new OperatingSystemSimulator(numUsers, numDisks, numPrinters);
        }
        return instance;
    }

    void startUserThreads() {
        for(UserThread u : users) {
            u.start();
        }
    }

    void joinUserThreads() {
        for(UserThread u : users) {
            try {
                u.join();
            } catch (InterruptedException e) {
                e.printStackTrace();
            }
        }
    }

    public static void main(String args[])
    {
        System.out.println("*** Operating System Simulation ***");
        for (int i=0; i<args.length; ++i) {
            System.out.println("Args[" + i + "] = " + args[i]);
        }

        int NUM_USERS    = Integer.parseInt(args[0].substring(1));
        int NUM_DISKS    = Integer.parseInt(args[1].substring(1));
        int NUM_PRINTERS = Integer.parseInt(args[2].substring(1));

        OperatingSystemSimulator os = OperatingSystemSimulator.getInstance(NUM_USERS, NUM_DISKS, NUM_PRINTERS);
        for(int i = 0; i < NUM_USERS; i++) {
            OperatingSystemSimulator.users[i] = new UserThread("USER" + i);
        }
        os.startUserThreads();
        os.joinUserThreads();
    }
}