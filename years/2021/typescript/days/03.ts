export async function run(input: string) {
  return [await runPart1(input), await runPart2(input)]
}

export async function runPart1(input: string) {
  const data = asStringArray(input)
  const width = data[0].length

  let gamma = ""
  let epsilon = ""

  for (let i = 0; i < width; ++i) {
    let count0 = 0
    let count1 = 0

    data.forEach(s => {
      switch (s[i]) {
        case "0":
          count0 += 1
          break

        case "1":
          count1 += 1
          break
      }
    })

    if (count1 > count0) {
      gamma += "1"
      epsilon += "0"
    } else {
      gamma += "0"
      epsilon += "1"
    }
  }

  return parseInt(gamma, 2) * parseInt(epsilon, 2)
}

export async function runPart2(input: string) {
  const data = asStringArray(input)
  const width = data[0].length

  return oxygenGeneratorRating(Array.from(data), width) * co2ScrubberRating(Array.from(data), width)
}

function asStringArray(data: string) {
  return data.trim().split(/\n+/).map(s => s.trim())
}

function co2ScrubberRating(culled: string[], width: number) {
  for (let i = 0; i < width; ++i) {
    culled = cullLeastCommon(culled, i)
  }
  return parseInt(culled[0], 2)
}

function cullLeastCommon(input: string[], index: number) {
  if (input.length == 1) {
    return input
  }

  let count0 = 0
  let count1 = 0

  input.forEach(s => {
    switch (s[index]) {
      case "0":
        count0 += 1
        break

      case "1":
        count1 += 1
        break
    }
  })

  if (count1 < count0) {
    return input.filter(s => s[index] == "1")
  } else {
    return input.filter(s => s[index] == "0")
  }
}

function cullMostCommon(input: string[], index: number) {
  if (input.length == 1) {
    return input
  }

  let count0 = 0
  let count1 = 0

  input.forEach(s => {
    switch (s[index]) {
      case "0":
        count0 += 1
        break

      case "1":
        count1 += 1
        break
    }
  })

  if (count0 > count1) {
    return input.filter(s => s[index] == "0")
  } else {
    return input.filter(s => s[index] == "1")
  }
}

function oxygenGeneratorRating(culled: string[], width: number) {
  for (let i = 0; i < width; ++i) {
    culled = cullMostCommon(culled, i)
  }
  return parseInt(culled[0], 2)
}
