package moe.shizuku.server;

// Personal fork: added brief method documentation for clarity
interface IRemoteProcess {

    /** Returns the output stream of the remote process. */
    ParcelFileDescriptor getOutputStream();

    /** Returns the input stream of the remote process. */
    ParcelFileDescriptor getInputStream();

    /** Returns the error stream of the remote process. */
    ParcelFileDescriptor getErrorStream();

    /** Waits for the process to terminate and returns the exit code. */
    int waitFor();

    /** Returns the exit value of the process; throws if still running. */
    int exitValue();

    /** Destroys (kills) the remote process. */
    void destroy();

    /** Returns true if the process is still alive. */
    boolean alive();

    /** Waits up to the given timeout for the process to terminate. */
    boolean waitForTimeout(long timeout, String unit);
}
