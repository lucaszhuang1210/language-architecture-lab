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
    String fileName;

    Printer(int id) {
        fileName = "PRINTER" + id;

        // Create/clear the file at startup (optional but useful)
        try {
            FileWriter fw = new FileWriter(fileName, false);
            fw.close();
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

        try (FileWriter writer = new FileWriter(fileName, true)) {
            writer.write(data.toString());
            writer.write("\n");       
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}

class PrintJobThread extends Thread {
    StringBuffer line = new StringBuffer();
    StringBuffer fileName = new StringBuffer();

    // references to global managers
    static DirectoryManager dirManager;
    static DiskManager diskManager;
    static PrinterManager printerManager;

    PrintJobThread(String fileToPrint)
    {
        fileName.append(fileToPrint);
    }

    public void run() {
        FileInfo info = dirManager.lookup(fileName);
        if (info == null) {
            System.out.println("File not found: " + fileName);
            return;
        }

        int diskNum = info.diskNumber;
        int start   = info.startingSector;
        int length  = info.fileLength;

        // 2. Ask for a printer (blocks if none free)
        int printerID = printerManager.request();  
        Printer printer = printerManager.get(printerID);

        // 3. Read from disk sector-by-sector and print each line
        Disk disk = diskManager.getDisk(diskNum);

        for (int i = 0; i < length; i++) {
            line.setLength(0);       // clear buffer before reading
            disk.read(start + i, line);
            printer.print(line);
        }

        // 4. Release the printer
        printerManager.release(printerID);
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
}

class PrinterManager
{
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
                    saveFile(args[1], args[2]);
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
                DirectoryManager.enter(name, makeFileInfo(d, offset, fileLines));
                break;
            }
            disks[d].write(offset + fileLines, line);
            fileLines++;
        }

        DiskManager.setNextFreeSectorOnDisk(d, offset + fileLines);
        DiskManager.release(d);
    }

    void printFile(String fileName) {
        new PrintJobThread(fileName).start();
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
        for (int i=0; i<args.length; ++i)
            System.out.println("Args[" + i + "] = " + args[i]);
            
        System.out.println("*** 141 OS Simulation ***");
    }
}
