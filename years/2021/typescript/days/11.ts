import { Cell, Grid } from "../grid";

export async function run(input: string) {
  return [await runPart1(input), await runPart2(input)]
}

export async function runPart1(input: string) {
	const grid = new Grid({ serialized: input.trim() });
	const iterations = 100;
	let flashes = 0;

	for (let i = 0; i < iterations; ++i) {
		for (const cell of grid) {
			incrementCell(cell);
		}

		const flashed = grid.getCells("*");
		flashes += flashed.length;

		for (const cell of flashed) {
			cell.setValue("0");
		}
	}

	return flashes;
}

export async function runPart2(input: string) {
	const grid = new Grid({ serialized: input.trim() });
	const cellCount = grid.rowCount * grid.colCount;
	let iterations = 0;
	let synchronized = false;

	while (!synchronized) {
		++iterations;

		for (const cell of grid) {
			incrementCell(cell);
		}

		const flashed = grid.getCells("*");
		synchronized = flashed.length === cellCount;

		for (const cell of flashed) {
			cell.setValue("0");
		}
	}

	return iterations;
}

function incrementCell(cell: Cell): Cell {
	const value = cell.value;
	if (value !== "*") {
		let newValue = Number(value) + 1;
		cell.setValue(newValue.toString());
		if (newValue > 9) {
			cell.setValue("*");
			for (const neighbor of cell.neighbors(true)) {
				incrementCell(neighbor);
			}
		}
	}
	return cell;
}
