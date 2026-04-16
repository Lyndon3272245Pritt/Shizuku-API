package moe.shizuku.server;

// Personal fork: added brief method documentation for clarity
interface IRemoteProcess {

    /** Returns the output stream of the remote process. */
    ParcelFileDescriptor getOutputStream();

    /** Returns the input stream of the remote process. */
    ParcelFileDescriptor getInputStream();

    /** Returns the error stream of the remote process. */
    ParcelFileDescriptor getErrorStream();

    int waitFor();

    int exitValue();

    void destroy();

    boolean alive();

    boolean waitForTimeout(long timeout, String unit);
}
