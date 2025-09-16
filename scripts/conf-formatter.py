import configparser
import argparse


def parse_args():
    parser = argparse.ArgumentParser(
        description="format json",
        formatter_class=argparse.ArgumentDefaultsHelpFormatter,
    )
    parser.add_argument("input", default=None, type=str, help="Input file path")
    parser.add_argument(
        "output",
        nargs="?",
        default=None,
        type=str,
        help="Output file path, defaults to input",
    )

    args = parser.parse_args()

    if args.output is None:
        output = args.input
    else:
        output = args.output

    return (args.input, output)


def main():
    input, output = parse_args()
    cfg = configparser.ConfigParser(strict=False, delimiters=("="))
    cfg.read(input)

    with open(output, "w") as f:
        for section in cfg.sections():
            header = f"[{section}]\n"
            f.write(header)

            for key in sorted(cfg[section]):
                entry = f"{key}={cfg[section][key]}\n"
                f.write(entry)
            f.write("\n")


if __name__ == "__main__":
    main()
