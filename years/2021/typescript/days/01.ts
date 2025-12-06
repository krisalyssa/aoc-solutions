export async function run(data: string) {
  return [await runPart1(data), await runPart2(data)]
}

export async function runPart1(data: string) {
  const values = asNumberArray(data)
  return asWindows(values, 2).map(pair => (pair[0] < pair[1] ? 1 : 0) as number).reduce((acc, v) => acc + v, 0)
}

export async function runPart2(data: string) {
  const values = asWindows(asNumberArray(data), 3).map(window => window.reduce((acc, v) => acc + v, 0))
  return asWindows(values, 2).map(pair => (pair[0] < pair[1] ? 1 : 0) as number).reduce((acc, v) => acc + v, 0)
}

function asNumberArray(data: string, radix = 10) {
  return data.trim().split(/[,\s]+/).map(s => parseInt(s, radix))
}

// https://stackoverflow.com/a/59322890/688981
function asWindows<T>(arr: T[], size: number): T[][] {
  return Array.from({ length: arr.length - (size - 1) }, (_, index) => arr.slice(index, index + size))
}
