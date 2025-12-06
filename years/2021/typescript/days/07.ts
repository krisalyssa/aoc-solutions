import * as util from "../util";

export async function run(input: string) {
  return [await runPart1(input), await runPart2(input)]
}

export async function runPart1(input: string) {
	const data = util.numberify(input);

	const min = util.min(data).value;
	const max = util.max(data).value;
	let minFuel = max * data.length;

	for (let p = min; p <= max; ++p) {
		const fuel = constantFuelToPosition(data, p);
		if (fuel < minFuel) {
			minFuel = fuel;
		}
		if (fuel > minFuel) {
			break;
		}
	}

	return `${minFuel}`;
}

export async function runPart2(input: string) {
	const data = util.numberify(input);

	const min = util.min(data).value;
	const max = util.max(data).value;
	let minFuel = arithmeticSeries(max) * data.length;

	for (let p = min; p <= max; ++p) {
		const fuel = linearFuelToPosition(data, p);
		if (fuel < minFuel) {
			minFuel = fuel;
		}
		if (fuel > minFuel) {
			break;
		}
	}

	return `${minFuel}`;
}

function arithmeticSeries(n: number): number {
	return (n * (1 + n)) / 2;
}

function constantFuelToPosition(data: number[], position: number): number {
	return data.map((p: number) => Math.abs(p - position)).reduce((acc: number, f: number) => acc + f);
}

function linearFuelToPosition(data: number[], position: number): number {
	return data
		.map((p: number) => arithmeticSeries(Math.abs(p - position)))
		.reduce((acc: number, f: number) => acc + f);
}
