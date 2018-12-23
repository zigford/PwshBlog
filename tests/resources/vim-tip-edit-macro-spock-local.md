Vim tips, macro's

Google it and you will find a couple of methods to edit vim macros. Here is
the method I like and will continue to use.

---

_The following will paste a register to a new line, you edit the line and then
yank the content back to the register_

1. Go to a new line
2. In normal mode enter `"qp` where q is the register
3. Edit the line (use Ctrl+V Ctrl+M to add a return)
4. Type `"qyy` to yank the line into register q

Here are some key combo's you would have to type in for insert mode operations

* Enter: `Ctrl+v Ctrl+m`
* Escape: `Ctrl+v Ctrl+[`

You can also add a macro into your vimrc with the following vimscript

            let @q='oAn inserted macro^['

With this, the macro stored in the q register will use o to open a new line in insert
mode, type 'An inserted macro' and then go back to normal mode.

If you have any comments or feedback, please [email](mailto:jesse@zigford.org) me 
and let me know if you will allow your feedback to be posted here.

Tags: vim-tips, vim, vim-macros
