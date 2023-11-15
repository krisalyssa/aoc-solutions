import chalk from "chalk"
import { performance } from "perf_hooks"
import { log, logSolution } from "../../../util/log"
import * as test from "../../../util/test"
import * as util from "../../../util/util"

const YEAR = 2021
const DAY = 6

// solution path: /Users/ccottingham/Projects/advent-of-code/2021/years/2021/06/index.ts
// data path    : /Users/ccottingham/Projects/advent-of-code/2021/years/2021/06/data.txt
// problem url  : https://adventofcode.com/2021/day/6

async function p2021day6_part1(input: string, ...params: any[]) {
	const data = util.numberify(input)
	const days = params[0] || 80
	const timers = new Array()

	for (let i = 0; i < 9; ++i) {
		timers[i] = 0
	}

	data.forEach((i) => ++timers[i])

	for (let i = 0; i < days; ++i) {
		const spawning = timers.shift()
		timers.push(spawning)
		timers[6] += spawning
	}

	return timers.reduce((acc, n) => acc + n, 0)
}

async function p2021day6_part2(input: string, ...params: any[]) {
	const data = util.numberify(input)
	const days = params[0] || 256
	const timers = new Array()

	for (let i = 0; i < 9; ++i) {
		timers[i] = 0
	}

	data.forEach((i) => ++timers[i])

	for (let i = 0; i < days; ++i) {
		const spawning = timers.shift()
		timers.push(spawning)
		timers[6] += spawning
	}

	return timers.reduce((acc, n) => acc + n, 0)
}

async function run() {
	const testData = "3,4,3,1,2"
	const part1tests: TestCase[] = [
		{
			input: testData,
			expected: "26",
			extraArgs: [ 18 ]		// days to run simulation
		},
		{
			input: testData,
			expected: "5934",
			extraArgs: [ 80 ]		// days to run simulation
		}
	]
	const part2tests: TestCase[] = [
		{
			input: testData,
			expected: "26984457539",
			extraArgs: [ 256 ]	// days to run simulation
		}
	]

	// Run tests
	test.beginTests()
	await test.section(async () => {
		for (const testCase of part1tests) {
			test.logTestResult(testCase, String(await p2021day6_part1(testCase.input, ...(testCase.extraArgs || []))))
		}
	})
	await test.section(async () => {
		for (const testCase of part2tests) {
			test.logTestResult(testCase, String(await p2021day6_part2(testCase.input, ...(testCase.extraArgs || []))))
		}
	})
	test.endTests()

	// Get input and run program while measuring performance
	const input = await util.getInput(DAY, YEAR)

	const part1Before = performance.now()
	const part1Solution = String(await p2021day6_part1(input))
	const part1After = performance.now()

	const part2Before = performance.now()
	const part2Solution = String(await p2021day6_part2(input))
	const part2After = performance.now()

	logSolution(6, 2021, part1Solution, part2Solution)

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
