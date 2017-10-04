# 計算機結構 hw2

1. code 是怎麼實作

  - 在 operation selector 的地方，一一比對 `+` 、 `-` 、 `*` 、 `/` 四個符號，再跳到正確的 function 繼續執行
  - 在四則運算的地方，就一一寫上各個運算，另外在 `/` 的地方，事先判好除數是 0 的情況，再繼續運算
  - 在 itoa 的部分，先在 global data 的地方新增一個 byte array，讓之後回傳的時候可以回傳到這個 array
    接下來再把數字除以 1000 、 100 、 10 ，看被除數和除數，再個自加上 `'0'` 來轉化成 `char` 型態
  - 在 result 的地方，就把 return 回來的 array 轉存到 `output_ascii` 裡面

2. 編寫的平台(Ex: Windows, Linux or Apple)

	Ubuntu (Linux)
