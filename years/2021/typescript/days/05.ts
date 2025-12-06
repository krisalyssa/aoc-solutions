import Flatten from "@flatten-js/core"
import * as util from "../util";

export async function run(input: string) {
  return [await runPart1(input), await runPart2(input)]
}

export async function runPart1(input: string) {
	const segments = util.segmentify(input).filter(s => isHorizontal(s) || isVertical(s));
	const cells = new Map();

	segments.forEach(s => {
		let ps = s.ps;
		let pe = s.pe;

		if (isHorizontal(s)) {
			if (ps.x > pe.x) {
				ps = s.pe;
				pe = s.ps;
			}
			for (let i = ps.x; i <= pe.x; ++i) {
				const key = `[${i},${ps.y}]`;
				cells.set(key, (cells.get(key) || 0) + 1);
			}
		} else if (isVertical(s)) {
			if (ps.y > pe.y) {
				pe = s.ps;
				ps = s.pe;
			}
			for (let i = ps.y; i <= pe.y; ++i) {
				const key = `[${ps.x},${i}]`;
				cells.set(key, (cells.get(key) || 0) + 1);
			}
		}
	});

	return Array.from(cells.entries()).filter(([_p, v]) => v > 1).length;
}

export async function runPart2(input: string) {
	const segments = util.segmentify(input);
	const cells = new Map();

	segments.forEach(s => {
		let ps = s.ps;
		let pe = s.pe;

		if (isHorizontal(s)) {
			if (ps.x > pe.x) {
				ps = s.pe;
				pe = s.ps;
			}

			for (let i = ps.x; i <= pe.x; ++i) {
				const key = `[${i},${ps.y}]`;
				cells.set(key, (cells.get(key) || 0) + 1);
			}
		} else if (isVertical(s)) {
			if (ps.y > pe.y) {
				pe = s.ps;
				ps = s.pe;
			}

			for (let i = ps.y; i <= pe.y; ++i) {
				const key = `[${ps.x},${i}]`;
				cells.set(key, (cells.get(key) || 0) + 1);
			}
		} else {
			if (ps.x > pe.x) {
				ps = s.pe;
				pe = s.ps;
			}
			const dy = ps.y > pe.y ? -1 : 1;

			for (let x = ps.x, y = ps.y; x <= pe.x; ++x, y += dy) {
				const key = `[${x},${y}]`;
				cells.set(key, (cells.get(key) || 0) + 1);
			}
		}
	});

	return Array.from(cells.entries()).filter(([_p, v]) => v > 1).length;
}

function isHorizontal(s: Flatten.Segment): boolean {
	return s.ps.y == s.pe.y;
}

function isVertical(s: Flatten.Segment): boolean {
	return s.ps.x == s.pe.x;
}
