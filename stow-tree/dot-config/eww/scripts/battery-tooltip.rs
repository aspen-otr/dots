use std::process::{Command, Stdio};
use std::io::Write;

fn main() {
    let mut sh = Command::new("sh")
        .stdin(Stdio::piped())
        .stdout(Stdio::piped())
        .stderr(Stdio::piped()).spawn().unwrap();
    sh.stdin
        .as_mut()
        .unwrap()
        .write(b"acpi -b | cut -d, -f3\n").unwrap();
    let binding = String::from_utf8(sh.wait_with_output().unwrap().stdout).unwrap();
    let acpi_output = binding.trim();

    if acpi_output == "charging at zero rate - will never fully charge." {
        print!("fully charged (or weak charger)");
        return;
    }

    print!("{acpi_output}");
}
