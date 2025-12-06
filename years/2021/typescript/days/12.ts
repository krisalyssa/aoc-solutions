import * as util from "../util";

class Node {
	label: string;
	big: boolean;
	neighbors: Set<string>;

	constructor(label: string) {
		this.label = label;
		this.big = label == label.toUpperCase();
		this.neighbors = new Set();
	}

	addNeighbor(other: string) {
		this.neighbors.add(other);
	}
}

class Graph {
	nodes: Map<string, Node>;

	constructor() {
		this.nodes = new Map();
	}

	add(node: Node) {
		this.nodes.set(node.label, node);
	}

	get(label: string) {
		let node = this.nodes.get(label);
		if (!node) {
			node = new Node(label);
			this.add(node);
		}
		return node;
	}
}

export async function run(input: string) {
  return [await runPart1(input), await runPart2(input)]
}

export async function runPart1(input: string) {
	const data = util.lineify(input.trim());
	const graph = new Graph();

	for (let pair of data) {
		const [a, b] = pair.split("-");
		const nodeA = graph.get(a);
		const nodeB = graph.get(b);
		nodeA.addNeighbor(b);
		nodeB.addNeighbor(a);
	}

	const path = new Array<string>();
	path.push("start");
	const paths = new Array<Array<string>>();
	findAllPaths(graph, path, paths, "start", "end", smallOnceAndBig);

	return paths.length;
}

export async function runPart2(input: string) {
	const data = util.lineify(input.trim());
	const graph = new Graph();

	for (let pair of data) {
		const [a, b] = pair.split("-");
		const nodeA = graph.get(a);
		const nodeB = graph.get(b);
		nodeA.addNeighbor(b);
		nodeB.addNeighbor(a);
	}

	const path = new Array<string>();
	path.push("start");
	const paths = new Array<Array<string>>();
	findAllPaths(graph, path, paths, "start", "end", oneSmallTwiceAndBig);

	// for (let path of paths) {
	// 	console.log(`${path}`)
	// }

	return paths.length;
}

function anySmallCaveVisitedTwice(path: Array<string>): boolean {
	const counts = new Map<string, number>();
	for (let node of path.filter(label => label !== label.toUpperCase())) {
		counts.set(node, (counts.get(node) || 0) + 1);
	}
	return Array.from(counts.values()).some(n => n >= 2);
}

function findAllPaths(
	graph: Graph,
	path: Array<string>,
	solutions: Array<Array<string>>,
	startLabel: string,
	endLabel: string,
	nodeCanBeVisited: (path: Array<string>, nextLabel: string) => boolean
) {
	const node = graph.get(startLabel);
	for (let nextLabel of Array.from(node.neighbors)) {
		if (nextLabel === endLabel) {
			const solution = Array.from(path);
			solution.push("end");
			solutions.push(solution);
		} else {
			if (nodeCanBeVisited(path, nextLabel)) {
				path.push(nextLabel);
				findAllPaths(graph, path, solutions, nextLabel, endLabel, nodeCanBeVisited);
				path.pop();
			}
		}
	}
}

function oneSmallTwiceAndBig(path: Array<string>, nextLabel: string): boolean {
	if (nextLabel === "start") {
		return false;
	}

	if (nextLabel === nextLabel.toUpperCase()) {
		return true;
	}

	if (!path.includes(nextLabel)) {
		return true;
	}

	if (anySmallCaveVisitedTwice(path)) {
		return false;
	}

	return true;
}

function smallOnceAndBig(path: Array<string>, nextLabel: string): boolean {
	return !path.includes(nextLabel) || nextLabel === nextLabel.toUpperCase();
}
