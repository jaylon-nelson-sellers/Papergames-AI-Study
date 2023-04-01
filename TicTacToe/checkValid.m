function validity = checkValid(cordinate)
    if (cordinate > 3 || cordinate < 1)
        validity = 0;
        return;
    end
    validity = 1;
end