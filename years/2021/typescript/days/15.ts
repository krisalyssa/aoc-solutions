import aStar from "a-star"
import { Grid, GridPos } from "../grid"

export async function run(input: string) {
  return [await runPart1(input), await runPart2(input)]
}

export async function runPart1(input: string) {
	const grid = new Grid({ serialized: input.trim() });

	const result = aStar({
		start: [0, 0],
		isEnd: node => nodeEquals(node, endNode(grid)),
		neighbor: node =>
			grid
				.getCell(nodeToGridPos(node))!
				.neighbors()
				.map(cell => cell.position),
		heuristic: node => manhattanDistance(node, endNode(grid)),
		distance: (_node1, node2) => Number(grid.getCell(nodeToGridPos(node2))!.value),
	});

	switch (result.status) {
		case "success":
			return pathRisk(grid, result.path);

		case "noPath":
			return "no path";

		case "timeout":
			return "timeout";
	}

	return `unknown status "${result.status}"`;
}

// Don't overthink it.
// I went down several rabbit holes trying to be clever calculating cells on the fly.
// Then I realized that the grid in part 1 is 100x100, or 10K cells.
// The full map is 25 times that, or 250K cells. At four bytes per cell, that's just 1M.
// Cells would have to get pretty big before memory became a concern, and I don't think
// they are.
// So just brute-force it, and generate the full map.

export async function runPart2(input: string) {
	const tile = new Grid({ serialized: input.trim() });
	const grid = new Grid({ rowCount: tile.rowCount * 5, colCount: tile.colCount * 5 });

	for (let i = 0; i < 5; ++i) {
		let rowOffset = i * tile.rowCount;

		for (let j = 0; j < 5; ++j) {
			let colOffset = j * tile.colCount;

			for (let cell of tile) {
				const cellPos = cell.position;
				grid.setCell([cellPos[0] + rowOffset, cellPos[1] + colOffset], tiledValue(i, j, cell.value));
			}
		}
	}

	const result = aStar({
		start: [0, 0],
		isEnd: node => nodeEquals(node, endNode(grid)),
		neighbor: node =>
			grid
				.getCell(nodeToGridPos(node))!
				.neighbors()
				.map(cell => cell.position),
		heuristic: node => manhattanDistance(node, endNode(grid)),
		distance: (_node1, node2) => Number(grid.getCell(nodeToGridPos(node2))!.value),
	});

	switch (result.status) {
		case "success":
			return pathRisk(grid, result.path);

		case "noPath":
			return "no path";

		case "timeout":
			return "timeout";
	}

	return `unknown status "${result.status}"`;
}

function endNode(grid: Grid): number[] {
	return [grid.rowCount - 1, grid.colCount - 1];
}

function manhattanDistance(position1: number[], position2: number[]): number {
	return Math.abs(nodeRow(position2) - nodeRow(position1)) + Math.abs(nodeCol(position2) - nodeCol(position1));
}

function nodeCol(node: number[]): number {
	return node[1];
}

function nodeEquals(node1: number[], node2: number[]): boolean {
	return nodeRow(node1) === nodeRow(node2) && nodeCol(node1) === nodeCol(node2);
}

function nodeRow(node: number[]): number {
	return node[0];
}

function nodeToGridPos(node: number[]): GridPos {
	return [nodeRow(node), nodeCol(node)];
}

function pathRisk(grid: Grid, path: number[][]): number {
	// don't add the risk for the first cell
	return path.slice(1).reduce((acc, position) => acc + Number(grid.getCell([position[0], position[1]])!.value), 0);
}

function tiledValue(tileRow: number, tileCol: number, value: string): string {
	return (((Number(value) - 1 + tileRow + tileCol) % 9) + 1).toString();
}
