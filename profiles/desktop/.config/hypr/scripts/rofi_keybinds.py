#!/usr/bin/env python

import json
import subprocess
import re
import html


mod_map = {
    64: "SUPER",
    8: "ALT",
    4: "CTRL",
    1: "SHIFT",
}


def mod_to_string(modmask: int) -> str:
    res = []

    for bf, key in mod_map.items():
        if modmask & bf == bf:
            res.append(key)
            modmask -= bf

    if modmask != 0:
        res.append(f"({modmask})")

    return "_".join(res)


def get_rofi_input() -> str:
    bindstrs = []

    for bind in json.loads(subprocess.check_output(["hyprctl", "binds", "-j"])):
        mod = mod_to_string(bind["modmask"])
        key = bind["key"]
        dispatcher = bind["dispatcher"]
        args = bind["arg"]
        args_escaped = html.escape(args)

        if mod == "":
            modkey = key
        else:
            modkey = mod + "," + key

        bindstr = (
            f'<span color="lightgray">{modkey}</span>: '
            f'<span color="white">{dispatcher}</span> '
            f'<span color="white">{args_escaped}</span>'
        )

        bindstrs.append(bindstr)

    return "\n".join(bindstrs)


def dispatch(choice: str):
    pattern = r'<span color="white">(.*?)</span> <span color="white">(.*?)</span>'
    match = re.search(pattern, choice)

    if match:
        dispatcher = match.group(1)
        args_escaped = match.group(2)
        args = html.unescape(args_escaped)

        if dispatcher == "exec":
            cmd = args
        else:
            cmd = f"hyprctl dispatch {dispatcher} {args}"

        subprocess.run(cmd, shell=True)


def main():
    rofi_input = get_rofi_input()

    choice = subprocess.check_output(
        ["rofi", "-dmenu", "-i", "-markup-rows", "-p", "Hyprland Keybinds:"],
        input=rofi_input,
        text=True,
    )

    dispatch(choice)


if __name__ == "__main__":
    main()
