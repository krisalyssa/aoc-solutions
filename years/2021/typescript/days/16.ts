import * as util from "../util"

enum LengthMode {
	Width = 0,
	Count = 1,
}

type Packet = {
	version: number;
	typeID: number;
};

type NullablePacket = Packet | null;

type Literal = Packet & {
	value: number | undefined;
};

type Operator = Packet & {
	mode: LengthMode;
	packets: NullablePacket[];
};

export async function run(input: string) {
  return [await runPart1(input), await runPart2(input)]
}

export async function runPart1(input: string) {
	return versionSum(parseBitstream(input));
}

export async function runPart2(input: string) {
	return evaluate(parseBitstream(input));
}

function binaryToNumber(bits: string[]): number {
	return Number.parseInt(bits.join(""), 2);
}

function digitToBinary(digit: string): string {
	switch (digit) {
		case "1":
			return "0001";

		case "2":
			return "0010";

		case "3":
			return "0011";

		case "4":
			return "0100";

		case "5":
			return "0101";

		case "6":
			return "0110";

		case "7":
			return "0111";

		case "8":
			return "1000";

		case "9":
			return "1001";

		case "A":
			return "1010";

		case "B":
			return "1011";

		case "C":
			return "1100";

		case "D":
			return "1101";

		case "E":
			return "1110";

		case "F":
			return "1111";

		default:
			return "0000";
	}
}

function evaluate(packets: NullablePacket[]): number {
	return packets
		.reduce((acc, packet) => {
			if (packet === null) {
				return acc;
			}
			acc.push(evaluateOne(packet).value!);
			return acc;
		}, [] as number[])
		.shift()!;
}

function evaluateOne(packet: Packet): Literal {
	switch (packet.typeID) {
		case 0: { // sum
			const operands = (packet as Operator).packets;
			const value = operands
				.map(p => evaluateOne(p!))
				.reduce((acc, p) => acc + (p.value === undefined ? 0 : p.value), 0);
			return makeLiteral(value);
		}

		case 1: { // product
			const operands = (packet as Operator).packets;
			const value = operands
				.map(p => evaluateOne(p!))
				.reduce((acc, p) => acc * (p.value === undefined ? 1 : p.value), 1);
			return makeLiteral(value);
		}

		case 2: { // minimum
			const operands = (packet as Operator).packets;
			return makeLiteral(util.min(operands, p => evaluateOne(p!).value!).value);
		}

		case 3: { // maximum
			const operands = (packet as Operator).packets;
			return makeLiteral(util.max(operands, p => evaluateOne(p!).value!).value);
		}

		case 4: // literal
			return packet as Literal;

		case 5: { // greater than?
			const operands = (packet as Operator).packets;
			const lhs = evaluateOne(operands[0]!).value!;
			const rhs = evaluateOne(operands[1]!).value!;
			return makeLiteral(lhs > rhs ? 1 : 0);
		}

		case 6: { // less than?
			const operands = (packet as Operator).packets;
			const lhs = evaluateOne(operands[0]!).value!;
			const rhs = evaluateOne(operands[1]!).value!;
			return makeLiteral(lhs < rhs ? 1 : 0);
		}

		case 7: { // equal?
			const operands = (packet as Operator).packets;
			const lhs = evaluateOne(operands[0]!).value!;
			const rhs = evaluateOne(operands[1]!).value!;
			return makeLiteral(lhs == rhs ? 1 : 0);
		}

		default:
			return makeLiteral(0);
	}
}

function makeLiteral(value: number): Literal {
	return {
		version: 0,
		typeID: 4,
		value,
	};
}

function parseBitstream(input: string): NullablePacket[] {
	const data = util.lineify(input.trim());
	const bitstream = data[0]
		.split("")
		.map(digit => digitToBinary(digit))
		.join("")
		.split("");
	const packets = [];

	// this would be an opportunity to define an iterator on the bitstream, wouldn't it?
	// basically, read packets off of bitstream until empty and return a packet array

	while (bitstream.length > 0) {
		packets.push(readPacket(bitstream));
	}

	if (packets.at(-1) === null) {
		packets.pop();
	}

	return packets;
}

function readLiteral(bitstream: string[]): Literal {
	const version = readNumber(bitstream, 3);
	readNumber(bitstream, 3);
	let valueBits = [];

	while (bitstream[0] === "1") {
		bitstream.shift();
		valueBits.push(...bitstream.splice(0, 4));
	}
	bitstream.shift();
	valueBits.push(...bitstream.splice(0, 4));

	return {
		version,
		typeID: 4,
		value: binaryToNumber(valueBits),
	};
}

function readNumber(bitstream: string[], width: number): number {
	return binaryToNumber(bitstream.splice(0, width));
}

function readOperator(bitstream: string[]): Operator {
	const version = readNumber(bitstream, 3);
	const typeID = readNumber(bitstream, 3);
	const mode = readNumber(bitstream, 1) as LengthMode;
	const packets: NullablePacket[] = [];

	switch (mode) {
		case LengthMode.Width:
			{
				const width = readNumber(bitstream, 15);
				const subpacketBits = bitstream.splice(0, width);
				while (subpacketBits.length > 0) {
					packets.push(readPacket(subpacketBits));
				}
			}
			break;

		case LengthMode.Count:
			{
				const count = readNumber(bitstream, 11);
				for (let i = 0; i < count; ++i) {
					packets.push(readPacket(bitstream));
				}
			}
			break;
	}

	return {
		version,
		typeID,
		mode,
		packets,
	};
}

function readPacket(bitstream: string[]): Packet | null {
	if (bitstream.length < 6) {
		bitstream.splice(0, bitstream.length);
		return null;
	}

	if (binaryToNumber(bitstream.slice(3, 6)) === 4) {
		return readLiteral(bitstream);
	} else {
		return readOperator(bitstream);
	}
}

function versionSum(packets: NullablePacket[]): number {
	return packets.reduce((acc, packet) => {
		if (packet === null) {
			return acc;
		}

		if (packet.typeID !== 4) {
			acc += versionSum((packet as Operator).packets);
		}

		return acc + packet.version;
	}, 0);
}
