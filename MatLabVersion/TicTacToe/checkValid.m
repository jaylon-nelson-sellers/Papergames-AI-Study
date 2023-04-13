function validity = checkValid(cordinate)
    if (isempty(cordinate))
        validity = 0;
        return
    end
    if (cordinate > 3 || cordinate < 1)
        validity = 0;
        return;
    end
    validity = 1;
end