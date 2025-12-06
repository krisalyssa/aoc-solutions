import * as util from "../util";

type Point = { x: number; y: number };
type Area = { topLeft: Point; bottomRight: Point };
type Velocity = { dx: number; dy: number };

export async function run(input: string) {
  return [await runPart1(input), await runPart2(input)]
}

export async function runPart1(input: string) {
	const match = util.regexify(input.trim(), /x=([-\d]+)\.\.([-\d]+),\s+y=([-\d]+)\.\.([-\d]+)/);
	if (!match) {
		return "wrong regex for the input data";
	}

	const x1: number = Number(match[1]);
	const x2: number = Number(match[2]);
	const y1: number = Number(match[3]);
	const y2: number = Number(match[4]);

	const targetArea = {
		topLeft: {
			x: Math.min(x1, x2),
			y: Math.max(y1, y2),
		},
		bottomRight: {
			x: Math.max(x1, x2),
			y: Math.min(y1, y2),
		},
	};

	const ys: number[] = [];
	for (let x = 1; x <= targetArea.bottomRight.x; ++x) {
		for (let y = 1; y <= 200; ++y) {
			const points = track({ dx: x, dy: y }, targetArea);
			if (points.some(point => inTargetArea(point, targetArea))) {
				ys.push(...points.map(point => point.y));
			}
		}
	}

	return util.max(ys).elem;
}

export async function runPart2(input: string) {
	const match = util.regexify(input.trim(), /x=([-\d]+)\.\.([-\d]+),\s+y=([-\d]+)\.\.([-\d]+)/);
	if (!match) {
		return "wrong regex for the input data";
	}

	const x1: number = Number(match[1]);
	const x2: number = Number(match[2]);
	const y1: number = Number(match[3]);
	const y2: number = Number(match[4]);

	const targetArea = {
		topLeft: {
			x: Math.min(x1, x2),
			y: Math.max(y1, y2),
		},
		bottomRight: {
			x: Math.max(x1, x2),
			y: Math.min(y1, y2),
		},
	};

	let velocities = 0;
	for (let x = 1; x <= targetArea.bottomRight.x; ++x) {
		for (let y = targetArea.bottomRight.y; y <= 200; ++y) {
			const points = track({ dx: x, dy: y }, targetArea);
			if (points.some(point => inTargetArea(point, targetArea))) {
				velocities++;
			}
		}
	}

	return velocities;
}

function inTargetArea(p: Point, area: Area): boolean {
	return p.x >= area.topLeft.x && p.x <= area.bottomRight.x && p.y <= area.topLeft.y && p.y >= area.bottomRight.y;
}

function track(vi: Velocity, area: Area): Point[] {
	let point: Point = { x: 0, y: 0 };
	let velocity: Velocity = vi;
	const points: Point[] = [];

	while (point.x <= area.bottomRight.x && point.y >= area.bottomRight.y) {
		points.push({ x: point.x, y: point.y });

		point.x += velocity.dx;
		point.y += velocity.dy;

		velocity.dx = velocity.dx === 0 ? 0 : velocity.dx - 1;
		velocity.dy -= 1;
	}

	return points;
}
