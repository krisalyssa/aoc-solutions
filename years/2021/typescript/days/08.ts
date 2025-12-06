import { difference, intersection, union } from "../set"
import * as util from "../util"

export async function run(input: string) {
  return [await runPart1(input), await runPart2(input)]
}

export async function runPart1(input: string) {
	const data = util
		.lineify(input)
		.map(line => line.trim().split(" | "))
		.map(([signals, digits]) => [signals.split(" "), digits.split(" ")]);

	return data.reduce((acc, [_s, d]) => {
		const numDigits = d.filter(
			digit => digit.length == 2 || digit.length == 4 || digit.length == 3 || digit.length == 7
		).length;
		return acc + numDigits;
	}, 0);
}

export async function runPart2(input: string) {
	const data = util
		.lineify(input)
		.map(line => line.trim().split(" | "))
		.map(([signals, digits]) => [signals.split(" "), digits.split(" ")]);

	return data.reduce((acc, d) => acc + Number(solveDisplay(d[0], d[1])), 0);
}

function extractSignal(s: Set<string>): string {
	return Array.from(s.values())[0];
}

function solveDisplay(signalData: Array<string>, displayData: Array<string>): string {
	const signalPatterns = signalData.reduce((acc, signals) => {
		const signalSet = signals.split("").reduce((acc2, s) => {
			return acc2.add(s);
		}, new Set<string>());
		acc.push(signalSet);
		return acc;
	}, new Array<Set<string>>());

	const displaySignals = displayData.map(s => s.split("").sort().join(""));

	const signalMap: Map<string, string> = new Map();

	// rule 1

	const signals1 = signalPatterns.splice(
		signalPatterns.findIndex(s => s.size === 2),
		1
	)[0];
	const signals7 = signalPatterns.splice(
		signalPatterns.findIndex(s => s.size === 3),
		1
	)[0];
	const signalA = difference(signals7, signals1);
	signalMap.set("a", extractSignal(signalA));

	// rule 2

	const signals4 = signalPatterns.splice(
		signalPatterns.findIndex(s => s.size === 4),
		1
	)[0];
	const signalsWith6 = signalPatterns.filter(s => s.size === 6);
	const signalG = difference(
		difference(intersection(intersection(signalsWith6[0], signalsWith6[1]), signalsWith6[2]), signals4),
		signalA
	);
	signalMap.set("g", extractSignal(signalG));

	// rule 3

	const signals6 = signalsWith6.find(s => intersection(s, signals1).size === 1);
	const signalF = intersection(signals6!, signals1);
	signalMap.set("f", extractSignal(signalF));

	// rule 4

	const signalC = difference(signals1, signalF);
	signalMap.set("c", extractSignal(signalC));

	// rule 5

	const signalsWith5 = signalPatterns.filter(s => s.size === 5);
	const signals3 = signalsWith5.find(s => intersection(s, signals1).size === 2);
	const signalD = difference(difference(signals3!, signals1), union(signalA, signalG));
	signalMap.set("d", extractSignal(signalD));

	// rule 6

	const signalB = difference(signals4, union(union(signalC, signalD), signalF));
	signalMap.set("b", extractSignal(signalB));

	// rule 7

	const signals8 = signalPatterns.splice(
		signalPatterns.findIndex(s => s.size === 7),
		1
	)[0];
	const signalE = difference(
		signals8,
		union(union(union(union(union(signalA, signalB), signalC), signalD), signalF), signalG)
	);
	signalMap.set("e", extractSignal(signalE));

	// which signals need to be on for each digit to be displayed
	const digitMap: Map<string, string> = new Map();
	digitMap.set(
		"abcefg"
			.split("")
			.map(c => signalMap.get(c))
			.sort()
			.join(""),
		"0"
	);
	digitMap.set(
		"cf"
			.split("")
			.map(c => signalMap.get(c))
			.sort()
			.join(""),
		"1"
	);
	digitMap.set(
		"acdeg"
			.split("")
			.map(c => signalMap.get(c))
			.sort()
			.join(""),
		"2"
	);
	digitMap.set(
		"acdfg"
			.split("")
			.map(c => signalMap.get(c))
			.sort()
			.join(""),
		"3"
	);
	digitMap.set(
		"bcdf"
			.split("")
			.map(c => signalMap.get(c))
			.sort()
			.join(""),
		"4"
	);
	digitMap.set(
		"abdfg"
			.split("")
			.map(c => signalMap.get(c))
			.sort()
			.join(""),
		"5"
	);
	digitMap.set(
		"abdefg"
			.split("")
			.map(c => signalMap.get(c))
			.sort()
			.join(""),
		"6"
	);
	digitMap.set(
		"acf"
			.split("")
			.map(c => signalMap.get(c))
			.sort()
			.join(""),
		"7"
	);
	digitMap.set(
		"abcdefg"
			.split("")
			.map(c => signalMap.get(c))
			.sort()
			.join(""),
		"8"
	);
	digitMap.set(
		"abcdfg"
			.split("")
			.map(c => signalMap.get(c))
			.sort()
			.join(""),
		"9"
	);

	return displaySignals.map(s => digitMap.get(s)).join("");
}
