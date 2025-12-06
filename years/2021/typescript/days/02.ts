export async function run(data: string) {
  return [await runPart1(data), await runPart2(data)]
}

export async function runPart1(data: string) {
  let h = 0
  let v = 0

  asStringArray(data).forEach(s => {
    const instruction = s.match(/(forward|down|up)\s+(\d+)/)
    if (instruction) {
      const direction = instruction[1]
      const amount = Number(instruction[2])

      switch (direction) {
        case "forward":
          h += amount
          break

        case "down":
          v += amount
          break

        case "up":
          v -= amount
          break
      }
    }
  })

  return h * v
}

export async function runPart2(data: string) {
  let h = 0
  let v = 0
  let aim = 0

  asStringArray(data).forEach(s => {
    const instruction = s.match(/(forward|down|up)\s+(\d+)/)
    if (instruction) {
      const direction = instruction[1]
      const amount = Number(instruction[2])

      switch (direction) {
        case "forward":
          h += amount
          v += aim * amount
          break

        case "down":
          aim += amount
          break

        case "up":
          aim -= amount
          break
      }
    }
  })

  return h * v
}

function asStringArray(data: string) {
  return data.trim().split(/\n+/).map(s => s.trim())
}
