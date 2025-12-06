import { Cell, Grid } from "../grid"
import * as util from "../util"

export async function run(input: string) {
  return [await runPart1(input), await runPart2(input)]
}

export async function runPart1(input: string) {
	const grid = new Grid({ serialized: input.trim() });

	let lowPoints = new Array<Cell>();
	for (const cell of grid) {
		if (cell.neighbors().every(neighbor => neighbor.value > cell.value)) {
			lowPoints.push(cell);
		}
	}

	return lowPoints.reduce((acc, cell) => acc + Number(cell.value) + 1, 0);
}

export async function runPart2(input: string) {
	const grid = new Grid({ serialized: input.trim() });

	const lowPoints = new Array<Cell>();
	for (const cell of grid) {
		if (cell.neighbors().every(neighbor => neighbor.value > cell.value)) {
			lowPoints.push(cell);
		}
	}

	const basins = new Array<Set<string>>();
	lowPoints.forEach((lp: Cell) => {
		const basin = new Set<string>();
		const candidates = new Array<Cell>();
		const visited = new Set<string>();

		basins.push(basin);
		candidates.push(lp);
		while (candidates.length) {
			const candidate = candidates.pop();
			if (candidate) {
				if (!visited.has(candidate.toString()) && Number(candidate.value) < 9) {
					basin.add(candidate.toString());
					candidates.push(
						...candidate
							.neighbors()
							.filter(neighbor => !visited.has(neighbor.toString()) && Number(neighbor.value) < 9)
					);
				}
				visited.add(candidate.toString());
			}
		}
	});

	const threeLargest = Array<Set<string>>();

	for (let i = 0; i < 3; ++i) {
		const largest = util.max(basins, b => b.size);
		threeLargest.push(largest.elem);
		basins.splice(largest.index, 1);
	}

	return threeLargest.reduce((acc, basin) => acc * basin.size, 1);
}
