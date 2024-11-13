#!/usr/bin/env ruby

=begin
要件
./cal.rb で実行できること(ruby cal.rb としなくてよいこと)
-mで月を、-yで年を指定できる
ただし、-yのみ指定して一年分のカレンダーを表示する機能の実装は不要
引数を指定しない場合は、今月・今年のカレンダーが表示される
MacやWSLに入っているcalコマンドと同じ見た目になっている
OSのcalコマンドと自分のcalコマンドの両方の実行結果を載せてください
少なくとも1970年から2100年までは正しく表示される
=end

require "date"
require 'optparse'
params = {}
opt = OptionParser.new #コマンドラインのオプションを扱うクラスのこと
opt.on('-m VAL',/\A\d{1,2}\z/){|v| params[:m] = v}
opt.on('-y VAL', /\A\d{4}\z/){|v| params[:y] = v}

opt.parse!(ARGV)

if params[:m] != nil
    month = params[:m].to_i
else
    month = Date.today.month
end

if params[:y] != nil
    year = params[:y].to_i
else
    year = Date.today.year
end


#Dateライブラリで今日の日付など
day = Date.today.day
#month = Date.today.month
#year = Date.today.year

# -1で最後の日（その月の最後の日）、＋1で最初の日
first_day_of_month = Date.new(year,month,+1)
last_day_of_month = Date.new(year,month,-1)
#p first_day_of_month
#p last_day_of_month
youbi = first_day_of_month.strftime("%A")
#p "初日は#{youbi}です"

days_of_month = last_day_of_month.day
#p days_of_month 
days_of_month_array = (1...days_of_month+1).to_a

#カレンダー表示時に、1日が日曜以外だった場合に、数字の前にスペースを追加
youbi_space_array = {"Sunday"=>0,"Monday"=>1,"Tuesday"=>2,"Wednesday"=>3,"Thursday"=>4,"Friday"=>5,"Saturday"=>6}
#p youbi_space_array[youbi]

# 初日は表示位置をスペースで調整するので、そのための定数。
first_day = 1

def padding(day)
    #日付が9以下の場合は、paddingが必要。
    if day <= 9
        return " "+"#{day}"
    else
        return day.to_s
    end
end

print "      #{month}月 #{year}\n"
print "日 月 火 水 木 金 土\n"

days_of_month_array.each do |i|
    date = Date.new(year, month, i)
    is_saturday = date.saturday?
    day = i
    if day == first_day
        space_count = youbi_space_array[youbi]
        space_final_num = space_count * 3
        print(" "*space_final_num)
    end
    day_with_padding = padding(day)
    if is_saturday
        print "#{day_with_padding}\n"
    else
        print "#{day_with_padding}"+" "
    end
end

# 末日の曜日が土曜日以外は、改行されないので、１行改行を追加する。(calプログラムの挙動に合わせる)
if not last_day_of_month.saturday?
    puts
end
#calプログラムで最終行に空行がついているので合わせる。
puts
