function y = huffmanDecode(x)
    
y = "";

keys = {'e','t','a','o','i','n','s','h','r','d','l','c','u','m','w','f','g','y','p','b','v','k','j','x','q','z', ' '};
values = {'01101','01011','01001','00110','00100','00010','00000','011111','011110','011101','011100','011000','011001','010001','010101','010100','001011','000111','001010','000011','000010','0100001','0001100','0001101','01000001','01000000', '00111'};

dict1 =containers.Map(keys, values);
dict2 = containers.Map(values, keys);
temp = "";

for i = 1: length(x)
    temp = temp+x(i);
    if(isKey(dict2, char(temp)))
        y = y+dict2(char(temp));
        temp = "";
    end
end

end