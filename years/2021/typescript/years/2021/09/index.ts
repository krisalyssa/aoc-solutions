import chalk from "chalk"
import { performance } from "perf_hooks"
import { Cell, Grid } from "../../../util/grid"
import { log, logSolution } from "../../../util/log"
import * as test from "../../../util/test"
import * as util from "../../../util/util"

const YEAR = 2021
const DAY = 9

// solution path: /Users/ccottingham/Projects/advent-of-code/2021/years/2021/09/index.ts
// data path    : /Users/ccottingham/Projects/advent-of-code/2021/years/2021/09/data.txt
// problem url  : https://adventofcode.com/2021/day/9

async function p2021day9_part1(input: string, ...params: any[]) {
	const grid = new Grid({ serialized: input.trim() })

	let lowPoints = new Array<Cell>()
	for (const cell of grid) {
		if (cell.neighbors().every((neighbor) => neighbor.value > cell.value)) {
			lowPoints.push(cell)
		}
	}

	return lowPoints.reduce((acc, cell) => acc + Number(cell.value) + 1, 0)
}

/**
 *  This is basically a flood fill, starting at a low point and bordered by cells of height 9.
 */
async function p2021day9_part2(input: string, ...params: any[]) {
	const grid = new Grid({ serialized: input.trim() })

	const lowPoints = new Array<Cell>()
	for (const cell of grid) {
		if (cell.neighbors().every((neighbor) => neighbor.value > cell.value)) {
			lowPoints.push(cell)
		}
	}

	const basins = new Array<Set<string>>()
	lowPoints.forEach((lp: Cell) => {
		const basin = new Set<string>()
		const candidates = new Array<Cell>()
		const visited = new Set<string>()

		basins.push(basin)
		candidates.push(lp)
		while (candidates.length) {
			const candidate = candidates.pop()
			if (candidate) {
				if (!visited.has(candidate.toString()) && (Number(candidate.value) < 9)) {
					basin.add(candidate.toString())
					candidates.push(...candidate.neighbors().filter((neighbor) => !visited.has(neighbor.toString()) && (Number(neighbor.value) < 9)))
				}
				visited.add(candidate.toString())
			}
		}
	})

	const threeLargest = Array<Set<string>>()

	for (let i = 0; i < 3; ++i) {
		const largest = util.max(basins, (b) => b.size)
		threeLargest.push(largest.elem)
		basins.splice(largest.index, 1)
	}

	return threeLargest.reduce((acc, basin) => acc * basin.size, 1)
}

async function run() {
	const testData = `
2199943210
3987894921
9856789892
8767896789
9899965678
`
	const part1tests: TestCase[] = [
		{
			input: testData,
			expected: "15"
		}
	]
	const part2tests: TestCase[] = [
		{
			input: testData,
			expected: "1134"
		}
	]

	// Run tests
	test.beginTests()
	await test.section(async () => {
		for (const testCase of part1tests) {
			test.logTestResult(testCase, String(await p2021day9_part1(testCase.input, ...(testCase.extraArgs || []))))
		}
	})
	await test.section(async () => {
		for (const testCase of part2tests) {
			test.logTestResult(testCase, String(await p2021day9_part2(testCase.input, ...(testCase.extraArgs || []))))
		}
	})
	test.endTests()

	// Get input and run program while measuring performance
	const input = await util.getInput(DAY, YEAR)

	const part1Before = performance.now()
	const part1Solution = String(await p2021day9_part1(input))
	const part1After = performance.now()

	const part2Before = performance.now()
	const part2Solution = String(await p2021day9_part2(input))
	const part2After = performance.now()

	logSolution(9, 2021, part1Solution, part2Solution)

	log(chalk.gray("--- Performance ---"))
	log(chalk.gray(`Part 1: ${util.formatTime(part1After - part1Before)}`))
	log(chalk.gray(`Part 2: ${util.formatTime(part2After - part2Before)}`))
	log()
}

run()
	.then(() => {
		process.exit()
	})
	.catch(error => {
		throw error
	})
