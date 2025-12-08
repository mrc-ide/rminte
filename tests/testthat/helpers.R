# Helper functions for testing

# Set matplotlib backend to Agg BEFORE any Python imports
# This fixes Tcl/Tk issues on Windows CI with uv-managed Python
# See: https://github.com/matplotlib/matplotlib/issues/28957
Sys.setenv(MPLBACKEND = "Agg")

python_pkgs_available <- function(pkgs = c("numpy", "pandas", "minte")) {
 found <- unlist(lapply(pkgs, reticulate::py_module_available))
 all(found)
}

skip_if_no_python_pkgs <- function(pkgs = c("numpy", "pandas", "minte")) {
 if (!python_pkgs_available(pkgs)) {
   testthat::skip(paste("Python packages not available for testing:", 
                        paste(pkgs[!unlist(lapply(pkgs, reticulate::py_module_available))], collapse = ", ")))
 }
}

# Setup for macOS thread safety with PyTorch
mac_thread_safe_setup <- function() {
 if (python_pkgs_available()) {
   if (Sys.info()[["sysname"]] == "Darwin") {
     tryCatch({
       reticulate::py_run_string("
import torch
torch.set_num_threads(1)
torch.set_num_interop_threads(1)
")
       message("[INFO] PyTorch threads set to 1 for macOS stability.")
     }, error = function(e) {
       # torch may not be directly importable, that's ok
     })
   }
 }
}

mac_thread_safe_setup()
