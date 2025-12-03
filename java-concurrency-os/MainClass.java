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
    Disk disk;
    DirectoryManager directoryManager;
    Printer printer;

    StringBuffer line;

    PrintJobThread(String fileToPrint, Disk disk, DirectoryManager directoryManager) {
        this.fileName = fileToPrint;
        this.line = new StringBuffer();
        this.disk = disk;
        this.directoryManager = directoryManager;
    }

    public void run() {
        FileInfo f = directoryManager.lookup(new StringBuffer(fileName));
        if (f == null) {
            System.out.println("File not found: " + fileName);
            return;
        }

        int start = f.startingSector;
        int p = PrinterManager.request();
        printer = new Printer(p);
        for (int i = 0; i < f.fileLength; i++) {
            disk.read(start+i, line);
            printer.print(line);
        }
    }
}

class FileInfo
{
    int diskNumber;
    int startingSector;
    int fileLength;
}


class DirectoryManager {
    private Hashtable<String, FileInfo> T = new Hashtable<String, FileInfo>();

    DirectoryManager() {}

    void enter(StringBuffer fileName, FileInfo file) {
        T.put(fileName.toString(), file);
    }

    FileInfo lookup(StringBuffer fileName)
    {
        return T.get(fileName.toString());
    }
}

class ResourceManager
{
}

class DiskManager
{
    static int nextFreeSector = 0;
    
    static int request() {
        return 0;
    }
    
    static int getNextFreeSectorOnDisk(int d) {
        return nextFreeSector;
    }
    
    static void setNextFreeSectorOnDisk(int d, int sector) {
        nextFreeSector = sector;
    }
    
    static void release(int d) {
    }
}

class PrinterManager
{
    static int request() {
        return 0;
    }
}

class UserThread extends Thread {
    String fileName;
    String line;

    // temp vars for this hw
    Disk disk;
    DirectoryManager directoryManager;
    Printer printer;
    static int nextFreeSector = 0;

    UserThread(String fileName, Disk disk, DirectoryManager directoryManager, Printer printer) {
        this.fileName = "USER" + fileName;
        this.disk = disk;
        this.directoryManager = directoryManager;
        this.printer = printer;
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

    void saveFile(String fileName, BufferedReader reader) throws Exception {
        int d = DiskManager.request();   // DiskNumber
        int offset = DiskManager.getNextFreeSectorOnDisk(d);
        int fileLines = 0;

        while (true) {
            String line = reader.readLine();
            if (line == null) break;                 // safety
            if (line.equals(".end")) {
                directoryManager.enter(new StringBuffer(fileName), makeFileInfo(d, offset, fileLines));
                break;
            }
            disk.write(offset + fileLines, new StringBuffer(line));
            fileLines++;
        }

        DiskManager.setNextFreeSectorOnDisk(d, offset + fileLines);
        DiskManager.release(d);
    }

    FileInfo makeFileInfo(int d, int offset, int fileLines) {
        FileInfo info = new FileInfo();
        info.diskNumber = d;
        info.startingSector = offset;
        info.fileLength = fileLines;
        return info;
    }

    void printFile(String fileName) {
        PrintJobThread pjt = new PrintJobThread(fileName, disk, directoryManager);
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

public class MainClass
{
    public static void main(String args[])
    {
        System.out.println("*** 141 OS Simulation ***");

        for (int i=0; i<args.length; ++i)
            System.out.println("Args[" + i + "] = " + args[i]);

        Disk disk = new Disk();
        Printer printer = new Printer(0);
        DirectoryManager directoryManager = new DirectoryManager();

        UserThread user = new UserThread(String.valueOf(0), disk, directoryManager, printer);
        user.start();
        try {
            user.join();
        } catch (InterruptedException ie) {}
    }
}