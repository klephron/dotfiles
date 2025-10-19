import json
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

    if input == output:
        file = open(input, "r+")
        ifile = file
        ofile = file
    else:
        ifile = open(input, "r")
        ofile = open(output, "w")

    obj = json.load(ifile)

    if ifile == ofile:
        # set pointer to starting pos cuz file will be appened by dump
        ifile.seek(0)
        ifile.truncate()

    json.dump(obj, ofile, indent=2, sort_keys=True)

    ifile.close()
    ofile.close()


if __name__ == "__main__":
    main()
