// I owe a huge debt of gratitude to [ric2b](https://github.com/ric2b) for this solution.
// I wrestled with the code for eight days and never could get anything to properly work,
// much less produce invalid answers. I have taken their solution, added types, and
// renamed variables. I may tear it apart and rebuild it some more in an effort to better
// understand how it works. Everything successful about it should be credited to ric2b,
// and everything which isn't is my fault.

import * as util from "../util"

type Tree = {
	p: string;
	v: any[] | number;
};

export async function run(input: string) {
  return [await runPart1(input), await runPart2(input)]
}

export async function runPart1(input: string) {
	const numbers = util.lineify(input.trim()).map(s => JSON.parse(s));

	return magnitude(numbers.reduce(add));
}

export async function runPart2(input: string) {
	const numbers = util.lineify(input.trim()).map(s => JSON.parse(s));

	let max = 0;
	for (let i = 0; i < numbers.length; ++i) {
		for (let j = 0; j < numbers.length; ++j) {
			if (i !== j) {
				const mag = magnitude([numbers[i], numbers[j]].reduce(add));
				if (mag > max) {
					max = mag;
				}
			}
		}
	}

	return max;
}

function add(a: number, b: number) {
	const sum = [a, b];
	const tree = buildTree(sum);
	let adjacency;
	do {
		adjacency = buildAdjacencyList(tree);
	} while (explode(tree, adjacency) || split(tree, adjacency));
	return simplifyTree(tree);
}

function buildAdjacencyList(tree: Tree, adjacency: string[] = []): string[] {
	if (Array.isArray(tree.v)) {
		tree.v.forEach(c => buildAdjacencyList(c, adjacency));
	} else {
		adjacency.push(tree.p);
	}
	return adjacency;
}

function buildTree(sfNumber: any[], path = ""): Tree {
	const value: any[] = Array.isArray(sfNumber)
		? [buildTree(sfNumber[0], path + "L"), buildTree(sfNumber[1], path + "R")]
		: sfNumber;
	return { p: path, v: value };
}

function explode(tree: Tree, adjacency: string[], path = ""): boolean {
	const node = treeNode(tree, path);
	if (!Array.isArray(node.v)) return false;
	if (path.length === 4) {
		const [a, b] = node.v;
		const i = adjacency.findIndex(path => path === a.p);
		const pathToPrev = adjacency[i - 1];
		const pathToNext = adjacency[i + 2];
		if (pathToPrev) treeNode(tree, pathToPrev).v += a.v;
		if (pathToNext) treeNode(tree, pathToNext).v += b.v;
		node.v = 0;
		return true;
	}
	return explode(tree, adjacency, path + "L") || explode(tree, adjacency, path + "R");
}

function magnitude(sfNumber: any[]): number {
	return sfNumber.map(n => (Array.isArray(n) ? magnitude(n) : n)).reduce((a, b) => 3 * a + 2 * b);
}

function simplifyTree(tree: Tree): any[] | number {
	return (tree.v as any[]).map(c => (Array.isArray(c.v) ? simplifyTree(c) : c.v));
}

function split(tree: Tree, adjacency: string[], path = ""): boolean {
	const node = treeNode(tree, path);
	if (Array.isArray(node.v)) {
		return split(tree, adjacency, path + "L") || split(tree, adjacency, path + "R");
	}
	if (node.v < 10) return false;
	node.v = [
		{ p: node.p + "L", v: Math.floor(node.v / 2) },
		{ p: node.p + "R", v: Math.ceil(node.v / 2) },
	];
	return true;
}

function treeNode(tree: Tree, path: string): Tree {
	switch (path[0]) {
		case "L":
			return treeNode((tree.v as any[])[0], path.slice(1));
		case "R":
			return treeNode((tree.v as any[])[1], path.slice(1));
		default:
			return tree;
	}
}
