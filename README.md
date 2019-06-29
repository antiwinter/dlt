# Dwarf love Tauren

Dwarf love Tauren, or **DLT**, enables you to communicate between Alliane and Horde. **DLT** has two work modes: _**raw**_ and _**b256**_.

![](https://raw.githubusercontent.com/antiwinter/scrap/master/dlt/scenario.gif)


## **raw** mode

In **raw** mode, you don't require the opposite faction players also installing **DLT**. **DLT** translates your English into their language (Common or Orcish). So you can talk to them, but they are unable to reply you, cause you cannot understand their language. (DLT cannot translate their language back into your language)

The picture below describes what each kind of player see:

![](https://raw.githubusercontent.com/antiwinter/scrap/master/dlt/raw_en.jpg)

## **b256** mode

In **b256** mode, you require the opposite faction players also have **DLT** installed. In this mode, you can fully understand each other. You can even speak other languages like Chinese and Japanese.

The picture below describes what each kind of player see:

![](https://raw.githubusercontent.com/antiwinter/scrap/master/dlt/b256_en.jpg)

## 1 Install

### Opt 1: use [wowa](https://github.com/antiwinter/wowa)

```
wowa add antiwinter/dlt
```

### Opt 2: download zip from [release](https://github.com/antiwinter/dlt/releases)

## 2 Usage

### 2.1 Sending message

```
/dlt hello
/dlt what ever you wanna say
```

### 2.2 Switching mode

```
/dlt mode
```

This command swtiches between **raw** and **b256** mode

### 2.3 Masking (filtering)

```
/dlt mask
```

This command turns on/off filtering the trash(encoded) charactors generated by **DLT**

## Feedback

If you find any bugs when using this Addon, please submit an [issue](https://github.com/antiwinter/dlt/issues).
