# LaTeX-Thesis
A LaTeX document class for thesis writing

## Short description
The ```thesis``` document class is designed to simplify the task of thesis writing in LaTeX.
This repository contains the source code for this class, documentation in PDF format, and also a minimal ```.tex``` source text to give you a headstart in writing your thesis.

## Repository contents
The following are the contents of the three directories in this repository.

- #### Class  
  Contains the files ```thesis.cls``` and ```thesis.clo``` that together constitute the source code for the ```thesis``` class.
- #### Documentation  
  Contains the file ```documentation.pdf```, which is the documentation for the ```thesis``` class.
  Also contains the LaTeX source from which this document can be generated (see the *"Compilation"* section in this README).
- #### Headstart  
  Contains a template to help you quickly start writing your thesis under the ```thesis``` document class.

## Compilation
This method works if using TeXlive on a Linux machine.
Make sure ```biber``` is also installed on your system.

I expect it to work on other systems with different LaTeX distributions too, but I haven't tested this.

#### Step 1:  
Navigate to the directory containing your ```.tex``` source file.
Let us assume that the file name is ```thesis.tex```, for convenience.

#### Step 2:  
Copy the files ```thesis.cls``` and ```thesis.clo``` from the ```Class```  directory into the directory containing ```thesis.tex```

```$ cp <path-to-your-local-copy-of-this-repo>/Class/* .```
  
#### Step 3:
Run the following command sequence to generate the output PDF document.

```$ pdflatex thesis```  
```$ biber thesis```  
```$ pdflatex thesis```  
```$ pdflatex thesis```
