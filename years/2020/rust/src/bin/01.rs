use common::{Day, Part};
use itertools::Itertools;

pub fn main() {
    let mut data: Vec<String> = vec![];

    if common::load_data("../data/01.txt", &mut data).is_ok() {
        let part_1 = Part::new(part_1);
        let part_2 = Part::new(part_2);

        let mut day = Day::new(part_1, part_2);

        day.run(&data);

        println!("part 1: {}", day.part_1.result);
        println!("part 2: {}", day.part_2.result);

        println!("{}", day.to_string());
    } else {
        eprintln!("cannot open ../data/01.txt");
        std::process::exit(1);
    }
}

pub fn part_1(data: &[&str]) -> u64 {
    let parsed_data: Vec<u32> = data
        .iter()
        .filter_map(|value| value.parse::<u32>().ok())
        .collect();

    let mut pair: Vec<u32> = Vec::new();

    for combo in parsed_data.iter().combinations(2) {
        if combo.iter().copied().sum1::<u32>().unwrap() == 2020 {
            pair = combo.iter().copied().copied().collect();
            break;
        }
    }

    (pair.iter().product1::<u32>().unwrap()) as u64
}

pub fn part_2(data: &[&str]) -> u64 {
    let parsed_data: Vec<u32> = data
        .iter()
        .filter_map(|value| value.parse::<u32>().ok())
        .collect();

    let mut triple: Vec<u32> = Vec::new();

    for combo in parsed_data.iter().combinations(3) {
        if combo.iter().copied().sum1::<u32>().unwrap() == 2020 {
            triple = combo.iter().copied().copied().collect();
            break;
        }
    }

    (triple.iter().product1::<u32>().unwrap()) as u64
}

#[cfg(test)]
mod tests {
    use super::*;

    #[test]
    fn test_part_1() {
        assert_eq!(
            part_1(&vec!["1721", "979", "366", "299", "675", "1456"]),
            514_579
        );

        let mut data: Vec<String> = vec![];
        if common::load_data("../data/01.txt", &mut data).is_ok() {
            let data_as_strs: Vec<&str> = data.iter().map(|v| v.as_str()).collect();
            assert_eq!(part_1(&data_as_strs), 719_796)
        } else {
            eprintln!("cannot open ../data/01.txt");
            std::process::exit(1);
        }
    }

    #[test]
    fn test_part_2() {
        assert_eq!(
            part_2(&vec!["1721", "979", "366", "299", "675", "1456"]),
            241_861_950
        );

        let mut data: Vec<String> = vec![];
        if common::load_data("../data/01.txt", &mut data).is_ok() {
            let data_as_strs: Vec<&str> = data.iter().map(|v| v.as_str()).collect();
            assert_eq!(part_2(&data_as_strs), 144_554_112)
        } else {
            eprintln!("cannot open ../data/01.txt");
            std::process::exit(1);
        }
    }
}
