use common::{Day, Part};
// use itertools::Itertools;

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

pub fn part_1(data: &[&str]) -> i64 {
    // println!("{:?}", data[0]);
    data[0].chars().fold(0, |acc, e| {
        acc + match e {
            '(' => 1,
            ')' => -1,
            _ => 0,
        }
    }) as i64
}

pub fn part_2(data: &[&str]) -> i64 {
    let mut floor = 0;
    for (i, e) in data[0].chars().enumerate() {
        floor = floor
            + match e {
                '(' => 1,
                ')' => -1,
                _ => 0,
            };
        if floor < 0 {
            return (i + 1) as i64;
        }
    }
    0
}

#[cfg(test)]
mod tests {
    use super::*;

    #[test]
    fn test_part_1() {
        assert_eq!(part_1(&vec!["(())"]), 0);
        assert_eq!(part_1(&vec!["()()"]), 0);
        assert_eq!(part_1(&vec!["((("]), 3);
        assert_eq!(part_1(&vec!["(()(()("]), 3);
        assert_eq!(part_1(&vec!["))((((("]), 3);
        assert_eq!(part_1(&vec!["())"]), -1);
        assert_eq!(part_1(&vec!["))("]), -1);
        assert_eq!(part_1(&vec![")))"]), -3);
        assert_eq!(part_1(&vec![")())())"]), -3);
    }

    #[test]
    fn test_part_2() {
        assert_eq!(part_2(&vec![")"]), 1);
        assert_eq!(part_2(&vec!["()())"]), 5);
    }
}
