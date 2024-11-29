use common::{Day, Part};
// use itertools::Itertools;

pub fn main() {
    let mut data: Vec<String> = vec![];

    if common::load_data("../data/23.txt", &mut data).is_ok() {
        let part_1 = Part::new(part_1);
        let part_2 = Part::new(part_2);

        let mut day = Day::new(part_1, part_2);

        day.run(&data);

        println!("part 1: {}", day.part_1.result);
        println!("part 2: {}", day.part_2.result);

        println!("{}", day.to_string());
    } else {
        eprintln!("cannot open ../data/23.txt");
        std::process::exit(1);
    }
}

pub fn part_1(data: &[&str]) -> i64 {
    let parsed_data: Vec<u32> = data
        .iter()
        .filter_map(|value| value.parse::<u32>().ok())
        .collect();

    parsed_data.len() as i64
}

pub fn part_2(data: &[&str]) -> i64 {
    let parsed_data: Vec<u32> = data
        .iter()
        .filter_map(|value| value.parse::<u32>().ok())
        .collect();

    parsed_data.len() as i64
}

#[cfg(test)]
mod tests {
    // use super::*;

    #[test]
    fn test_part_1() {}

    #[test]
    fn test_part_2() {}
}
