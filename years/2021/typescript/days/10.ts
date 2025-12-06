import * as util from "../util";

const autocompleterSchedule: Map<string, number> = new Map([
	[")", 1],
	["]", 2],
	["}", 3],
	[">", 4],
]);

const closingCharacters: Map<string, string> = new Map([
	["(", ")"],
	["[", "]"],
	["{", "}"],
	["<", ">"],
]);

const syntaxCheckerSchedule: Map<string, number> = new Map([
	[")", 3],
	["]", 57],
	["}", 1197],
	[">", 25137],
]);

export async function run(input: string) {
  return [await runPart1(input), await runPart2(input)]
}

export async function runPart1(input: string) {
	return util.lineify(input.trim()).reduce((acc, line) => acc + syntaxCheckerScore(line), 0);
}

export async function runPart2(input: string) {
	const data = util
		.lineify(input.trim())
		.filter(line => syntaxCheckerScore(line) == 0)
		.map(line => autocompleterScore(line))
		.sort((a, b) => Number(a) - Number(b));
	return data.at(data.length / 2);
}

// Autocompletion starts with syntax checking, or rather stripping valid chunks leaving an incomplete chunk.
// The last character will be the innermost opening character. Then repeatedly
//   1. determine the matching closing character
//   2. push the closing character to an array
//   3. append the closing character to the chunk
//   4. strip valid chunks again
//   5. if the string is not empty, go back to 1

function autocompleterScore(line: string): number {
	let incompleteLine = stripChunks(line);
	const autocompleteSequence = new Array<string>();

	while (incompleteLine.length > 0) {
		const lastOpener = incompleteLine.at(-1);
		if (lastOpener) {
			const closingChar = closingCharacters.get(lastOpener);
			if (closingChar) {
				autocompleteSequence.push(closingChar);
				incompleteLine = stripChunks(incompleteLine + closingChar);
			} else {
				break;
			}
		} else {
			break;
		}
	}

	return autocompleteSequence.reduce((acc, c) => acc * 5 + (autocompleterSchedule.get(c) || 0), 0);
}

function stripChunks(line: string): string {
	for (let i = line.length; i; --i) {
		line = line.replaceAll(/\(\)/g, "");
		line = line.replaceAll(/\[\]/g, "");
		line = line.replaceAll(/\{\}/g, "");
		line = line.replaceAll(/\<\>/g, "");
	}
	return line;
}

// The only characters in the lines are opening and closing characters, which means that at the innermost
// nesting of a valid chunk there will be one or more adjacent opening/closing characters. So we can remove
// adjacent opening/closing characters until the line is unchanged, then the resulting line will start
// with a corrupted chunk (if any). The corrupted closing character will be the first closing character in
// the line.
//
// For simplicity, rather than loop until the line is unchanged, just loop (line.length) times. That's a
// guaranteed hard limit on the number of opening/closing character pairs we can remove (the limit is
// actually (line.length / 2), but I don't want to mess with rounding up if the line length is an odd number,
// and lines should be short enough that twice too many iterations will take a long time).
//
// If the line is incomplete rather than corrupted, there will be no closing character, so return 0.

function syntaxCheckerScore(line: string): number {
	const badLine = stripChunks(line);
	const badIndex = badLine.search(/[\)\]\}\>]/);
	if (badIndex > -1) {
		return syntaxCheckerSchedule.get(badLine.charAt(badIndex)) || 0;
	} else {
		return 0;
	}
}
