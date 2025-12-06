type Square = number | undefined;
type Board = Square[];

const winners = [
	[0, 1, 2, 3, 4],
	[5, 6, 7, 8, 9],
	[10, 11, 12, 13, 14],
	[15, 16, 17, 18, 19],
	[20, 21, 22, 23, 24],

	[0, 5, 10, 15, 20],
	[1, 6, 11, 16, 21],
	[2, 7, 12, 17, 22],
	[3, 8, 13, 18, 23],
	[4, 9, 14, 19, 24],
];

export async function run(data: string) {
  return [await runPart1(data), await runPart2(data)]
}

export async function runPart1(data: string) {
	const matchData = data.trim().match(/^(\S+)\s+(.+)$/ms);
	if (!matchData) {
		return "no match in input";
	}

	const drawStr = matchData[1];
	const boardStrs = matchData[2].split(/\n\n+/);

	const draws = drawStr.split(",").map(Number);
	const boards: Board[] = boardStrs.map(s => s.trim().split(/\s+/).map(Number));

	let solution = undefined;
	for (let i = 0; i < draws.length && !solution; ++i) {
		const draw = draws[i];
		for (let j = 0; j < boards.length && !solution; ++j) {
			const board = boards[j];
			const index = board.indexOf(draw);
			if (index >= 0) {
				board[index] = undefined;
				if (isWinner(board)) {
					const remaining = board.reduce((acc: number, n: Square) => acc + (n || 0), 0);
					solution = draw * remaining;
					break;
				}
			}
		}
	}

	return solution;
}

export async function runPart2(data: string) {
	const matchData = data.trim().match(/^(\S+)\s+(.+)$/ms);
	if (!matchData) {
		return "no match in input";
	}

	const drawStr = matchData[1];
	const boardStrs = matchData[2].split(/\n\n+/);

	const draws = drawStr.split(",").map(Number);
	const boards: Board[] = boardStrs.map(s => s.trim().split(/\s+/).map(Number));

	let solution = undefined;
	for (let i = 0; i < draws.length; ++i) {
		const draw = draws[i];
		for (let j = 0; j < boards.length; ++j) {
			const board = boards[j];
			if (board.length) {
				const index = board.indexOf(draw);
				if (index >= 0) {
					board[index] = undefined;
					if (isWinner(board)) {
						const remaining = board.reduce((acc: number, n: Square) => acc + (n || 0), 0);
						solution = draw * remaining;
						boards[j] = [];
					}
				}
			}
		}
	}

	return solution;
}

function isWinner(board: Board): boolean {
	return winners.some(indices => {
		return indices.every(n => board[n] === undefined);
	});
}
