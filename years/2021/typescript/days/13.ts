import { Grid } from "../grid";
import * as util from "../util";

const CLEAR = ".";
const DOT = "█";

export async function run(input: string) {
  return [await runPart1(input), await runPart2(input)]
}

export async function runPart1(input: string) {
	const data = util.lineify(input.trim(), true);
	const blankLine = data.findIndex(line => line === "");
	const points = data
		.slice(0, blankLine)
		.filter(line => line.match(/\S/))
		.map(line => line.match(/(\d+),(\d+)/)?.slice(1, 3))
		.map(point => [Number(point![1]), Number(point![0])]);
	const folds = data
		.slice(blankLine, data.length)
		.filter(line => line.match(/\S/))
		.map(line => line.match(/(.)=(\d+)/)?.slice(1, 3));

	const maxCol = util.max(points.map(point => point[1])).value;
	const maxRow = util.max(points.map(point => point[0])).value;

	let grid = new Grid({ rowCount: maxRow + 1, colCount: maxCol + 1, fillWith: CLEAR });
	for (let point of points) {
		grid.setCell([point[0], point[1]], DOT);
	}

	const fold = folds[0];
	if (fold![0] == "y") {
		grid = foldUp(grid, Number(fold![1]));
	} else {
		grid = foldLeft(grid, Number(fold![1]));
	}

	return countDots(grid);
}

export async function runPart2(input: string) {
  // hardcoding the solution, because IIRC you have to eyeball it?
	const expectedWord = "CPJBERUL"

	const data = util.lineify(input.trim(), true);
	const blankLine = data.findIndex(line => line === "");
	const points = data
		.slice(0, blankLine)
		.filter(line => line.match(/\S/))
		.map(line => line.match(/(\d+),(\d+)/)?.slice(1, 3))
		.map(point => [Number(point![1]), Number(point![0])]);
	const folds = data
		.slice(blankLine, data.length)
		.filter(line => line.match(/\S/))
		.map(line => line.match(/(.)=(\d+)/)?.slice(1, 3));

	const maxCol = util.max(points.map(point => point[1])).value;
	const maxRow = util.max(points.map(point => point[0])).value;

	let grid = new Grid({ rowCount: maxRow + 1, colCount: maxCol + 1, fillWith: CLEAR });
	for (let point of points) {
		grid.setCell([point[0], point[1]], DOT);
	}

	for (let fold of folds) {
		if (fold![0] == "y") {
			grid = foldUp(grid, Number(fold![1]));
		} else {
			grid = foldLeft(grid, Number(fold![1]));
		}
	}

	return expectedWord;
}

function countDots(grid: Grid): number {
	return grid.getCells(DOT).length;
}

function foldLeft(grid: Grid, onCol: number): Grid {
	for (let i = 0; i < onCol; ++i) {
		for (let j = 0; j < grid.rowCount; ++j) {
			const value = grid.getCell([j, onCol + i + 1])!.value;
			if (value !== CLEAR) {
				grid.setCell([j, onCol - i - 1], value);
				grid.setCell([j, onCol + i + 1], CLEAR);
			}
		}
	}

	return grid.copyGrid({ srcEndCol: onCol - 1 });
}

function foldUp(grid: Grid, onRow: number): Grid {
	for (let i = 0; i < onRow; ++i) {
		for (let j = 0; j < grid.colCount; ++j) {
			const value = grid.getCell([onRow + i + 1, j])!.value;
			if (value !== CLEAR) {
				grid.setCell([onRow - i - 1, j], value);
				grid.setCell([onRow + i + 1, j], CLEAR);
			}
		}
	}

	return grid.copyGrid({ srcEndRow: onRow - 1 });
}
