## tmux Notes

**tmux** = *terminal multiplexer*
It lets you manage multiple terminal sessions, windows, and panes inside one terminal.

### Basic commands

```bash
tmux
```

Starts a new tmux session.

```bash
tmux ls
tmux list-sessions
```

Shows all running tmux sessions.

```bash
tmux attach
```

Attach to the last active session.

```bash
tmux attach -t 0
```

Attach to session `0`.

---

### Main shortcut key

tmux uses a **prefix key** first:

**Ctrl + b**

After pressing `Ctrl + b`, press the next key for the action.

---

### Common tmux shortcuts

**Detach from tmux**

* `Ctrl + b` then `d`

**Split pane vertically**

* `Ctrl + b` then `%`

**Split pane horizontally**

* `Ctrl + b` then `"`

**Close current pane**

* `Ctrl + b` then `x`

**Create a new window**

* `tmux new-window`
* or `Ctrl + b` then `c`

**Go to previous window**

* `Ctrl + b` then `p`

**Go to next window**

* `Ctrl + b` then `n`

**Close current window**

* `Ctrl + b` then `&`

---

### Example session flow

1. Start tmux: `tmux`
2. Split screen: `Ctrl + b` then `%` or `"`
3. Detach: `Ctrl + b` then `d`
4. List sessions: `tmux ls`
5. Reattach: `tmux attach`

---