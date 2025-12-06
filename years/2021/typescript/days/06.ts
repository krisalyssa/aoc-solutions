import * as util from "../util";

export async function run(input: string) {
  return [await runPart1(input), await runPart2(input)]
}

export async function runPart1(input: string) {
	const data = util.numberify(input);
	const days = 80;
	const timers = new Array();

	for (let i = 0; i < 9; ++i) {
		timers[i] = 0;
	}

	data.forEach(i => ++timers[i]);

	for (let i = 0; i < days; ++i) {
		const spawning = timers.shift();
		timers.push(spawning);
		timers[6] += spawning;
	}

	return timers.reduce((acc, n) => acc + n, 0);
}

export async function runPart2(input: string) {
	const data = util.numberify(input);
	const days = 256;
	const timers = new Array();

	for (let i = 0; i < 9; ++i) {
		timers[i] = 0;
	}

	data.forEach(i => ++timers[i]);

	for (let i = 0; i < days; ++i) {
		const spawning = timers.shift();
		timers.push(spawning);
		timers[6] += spawning;
	}

	return timers.reduce((acc, n) => acc + n, 0);
}
