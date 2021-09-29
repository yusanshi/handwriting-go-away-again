# Handwriting Go Away AGAIN

Make a LaTeX document in Chinese look like handwritten. See <https://yusanshi.com/posts/handwriting-go-away-again/>.

## Requirements

- Linux-based OS
- Bash Shell
- XeLaTeX and xeCJK
- Ghostscript (`gs` command)
- ImageMagick (`convert` command, possibly this command may fail due to ImageMagick's security policy, see <https://stackoverflow.com/questions/52998331/imagemagick-security-policy-pdf-blocking-conversion> for the solution if that's the case)

## Get Started

```bash
git clone https://github.com/yusanshi/handwriting-go-away-again
cd handwriting-go-away-again
./handwriting/convert.sh demo.tex
```

Usually you may want to copy `handwriting` directory to the directory where your TeX files are located, and run `./handwriting/convert.sh FILE.tex` in that directory.

Note the `\input{handwriting/main.tex}` in `demo.tex`. Comment out that line to view the *original* look of the document. Uncomment it to have a quick view of the *handwritten* document, and when it looks good, run `./handwriting/convert.sh demo.tex` to get the final converted document.
