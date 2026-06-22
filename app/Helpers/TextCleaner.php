<?php

namespace App\Helpers;

class TextCleaner
{
    /**
     * CJK Character translation map.
     * Maps Chinese/Han characters to Vietnamese terms.
     */
    protected static array $cjkMap = [
        '要求' => ' yêu cầu ',
        '快速' => ' nhanh chóng ',
        '流畅' => ' mượt mà ',
        '配置' => ' cấu hình ',
        '运行' => ' chạy / vận hành ',
        '游戏' => ' chơi game ',
        '办公' => ' văn phòng ',
        '电脑' => ' máy tính ',
        '处理器' => ' bộ xử lý ',
        '显卡' => ' card đồ họa ',
        '内存' => ' RAM ',
        '硬盘' => ' ổ cứng ',
    ];

    /**
     * Clean and translate CJK (Chinese/Japanese/Korean) characters in the text.
     *
     * @param string $text
     * @return string
     */
    public static function cleanCjk(string $text): string
    {
        $text = strtr($text, self::$cjkMap);
        $text = preg_replace('/\p{Han}/u', '', $text);
        $text = preg_replace('/\s+/', ' ', $text);
        $text = preg_replace('/\s+([.,;:?!])/', '$1', $text);
        return trim($text);
    }
}
