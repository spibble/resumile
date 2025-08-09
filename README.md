# resumile
A simple, modern Typst resume template based on the likes of Jake's and chicv.

## How to use
This template is not on Typst Universe, so you'll have to either do things locally or use the web interface. In either case,

1. **Clone this repo**: `git clone https://github.com/spibble/resumile.git`

Then your next steps will diverge, depending on the method.

### Running Locally
2. **Install Font Awesome 7 to your system**:
   - You can use `install_fontawesome.sh` to automatically download and install these fonts if you're on MacOS or Linux (note that you may need to first make it executable using `chmod +x install_fontawesome.sh`.
   - If you are on Windows or don't trust my script (very reasonable), you can manually download them at https://fontawesome.com/download.
3. **Create the resume file**: `touch main.typ` (or go straight into the text editor of your choice)
   
At this point, if you know how everything works, you can go straight into editing `main.typ`. In the future, there will be boilerplate or a template file I'll give to make it easy!

### Using the Typst web interface
2. **Create a new project**.
3. **Add `utils.typ` and the FontAwesome `.otf` files to the project**: If you used my script, you can find the files in `./fonts`; otherwise download them manually and just add them from wherever you downloaded them to.

At this point, if you know how everything works, you can go straight into editing `main.typ`. In the future, there will be boilerplate or a template file I'll give to make it easy!
