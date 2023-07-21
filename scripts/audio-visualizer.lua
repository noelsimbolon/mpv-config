-- various audio visualization

local opts = {
    mode = "novideo",
    -- off              disable visualization
    -- noalbumart       enable visualization when no albumart and no video
    -- novideo          enable visualization when no video
    -- force            always enable visualization

    name = "showcqt",
    -- off
    -- showcqt
    -- avectorscope
    -- showspectrum
    -- showcqtbar
    -- showwaves

    quality = "medium",
    -- verylow
    -- low
    -- medium
    -- high
    -- veryhigh

    height = 6,
    -- [4 .. 12]

    forcewindow = true,
    -- true (yes)       always run visualizer regardless of force-window settings
    -- false (no)       does not run visualizer when force-window is no
}

-- key bindings
-- cycle visualizer
local cycle_key = "c"

if not (mp.get_property("options/lavfi-complex", "") == "") then
    return
end

local visualizer_name_list = {
    "off",
    "showcqt",
    "avectorscope",
    "showspectrum",
    "showcqtbar",
    "showwaves",
}

local axis_0 = "image/png;base64," ..
"iVBORw0KGgoAAAANSUhEUgAAB4AAAAAgCAQAAABZEK0tAAAACXBIWXMAAA7EAAAOxAGVKw4bAAASO0lEQVR42u2de2wU1xXGV/IfSJEqVUJCQrIUISFFiiqhSFWkKFKFokpB1TqxHROT8ApueDgEE9u4MW4TSqFA" ..
"3TSUQmkSChRwII6BkAQCDSYlBtc1hiSA4/CyMcYGtsZvY3t3vXu719vVPjxzz71zd+wBvnOkdvHZ78w5v7mZmbt7Z9blgsFgMBgMBoPBYDAYDAaDwWAwGAwGg8FgMBgMBoPBYDAYDAaDwWCw+9HYBFbKboe8lE1A" ..
"HHHEEUccccQRRxxxxBFHHPEHNe4KBSJWijjiiCOOOOKII4444ogjjjjiD1icwWAwGAwGg8FgMBgM9hAYJsAwGAwGg8FgMBgMBnsozOVyR7zuQOSPdQeif0UcccQRRxxxxBFHHHHEEUcc8QciHn05KaPuwGDHYEfd" ..
"gUkZRgkQRxxxxBFHHHHEEUccccQRR/w+jhu9FQ6Hw+FwOBwOh8Ph8AfOx3Zz07LTXpmYzl89McuJOJ6e/czcCWkP7u4Gf/AHf/AHf/AHf/AHf/AHf/B/iPm73D99qaW2u7n7RqI/8lz4LWbxw1tVNjQh7dgH/Z6R" ..
"JdjBzmuXKxl7b42sdvqctrORCjqvTc1S3elx9V9vOXNy1+gcP3r+5K6Bu7y8YW/jqZO7PPU5S+Tyx/Fp9lysO/CLV1TqA3/wB3/wB3/wB3/wB3/wB3/wB/8x4e9yL37N+PlYP3o+/BazePVe+c089XL7D4n6qjJZ" ..
"dUlhrO7TLWo7wKj+gbvxkGbMv3sl8T3Ht8vlL8hLVPr6dq7Xqw/8wR/8wR/8wR/8wR/8wR/8wR/8k86f/89bK26eYazjSsXGsJ8ui90Bo+MVG7ua1HZAY1VoZj9Utacof8b8DSU15cGAmn5tcfnG/zaE2+tqUtsB" ..
"8fXv33T6w8EOxpprYt9xs46xgK9qT0Hes/M2rbr13cgA2SOfP+hnrLacZ68t72sNiYNvrbBWH/iDP/iDP/iDP/iDP/iDP/iDP/jbxD/8f3UVjF2v5q8ef9HlXpQbyjAcuxY7Gp8y8uV1878ZO7lLtsDNv+Ul/e5X" ..
"0b9cqlT9JGFypq+XscZTHM3bRaq7IFo/9z+/zZivPxrdsY7Xt35l5N8paV3XGavcLp8/4GMs0t+UrFvf8mESWcKgVh/4gz/4gz/4gz/4gz/4gz/4gz/428Q/vsC1xQFf9b5JGXcvf3/UqIE1bw57az5yuff/uadl" ..
"eZ5sefzzh8ZTsX+ZPmfvO5MzVRCWv8tXhz8xi6O5+pXeDqjaw1hvazTaFNqtjV/Hvn/Xho4ruUut7QCXO/vV4DBja95Ur0+Ff+Fy8Ad/8Ad/8Ad/8Ad/8Ad/8Ad/8FfgHy2wt7Wugs+d284aNxCJ36xTbb+7mbGj" ..
"76uq4p2vYb9U6XIf3sq/LH/qZfUdwOuvq/juM89F/nnD3ndi6gvt1C+06ovfAaGMN9Q6Bn/wB3/wB3/wB3/wB3/wB3/wB3/b+UcLjFjbOeMGRPFHnpu7yBzKPQ9jkduSH39xweKcJTlLFiz+Sbas3uVe9jrf8soC" ..
"rh8eZOzETpXtx9cfvgm7IOb76/6Y+sw8Je3Jl+R3AF/TfrpMXq/LX5yf5k/VR/FX6c8K/4npOUvi61XjT+l1+Yvz0/yp+ij+Kv1Z4f/oC4tyfz7POn9Kr8tfnJ/mT9VH8Vfpz9rxR+0EMPr4Q5+g9I4/Ipc5/oid" ..
"Pv7I9wf+9yf/1MxXc/kCQav8Rfpk8DfPL8dfVJ8Mf9n+MP7vv/HPr29/Nts6f0qfjOt/8/xy1/+i+mSu/2X7szb+017JWWK+qJYe/2K9/vgX5ZcZ/+L66PEv35/Djj/RAgfaG6u6Gs0/gTCPry4aaOdtNf/70ReM" ..
"NtJ/i7GyUv6qII/ffv1/Cxbly+ld7otH+Kr469Xcvd2M9d+OXSFP60fqv8vVzdWe+oCXsYA3+hV5/23GPvyjGaKfZB/a0nTK211/VH4H3DkfGiQ75PU6/On8Yv4y9Yn4S/dnkX9KWs1HXMEXUZj9epmIv4xehz+d" ..
"X8xfpj4Rf+n+LPJPzfz+GOfLWOfVuYvU+cvodfjT+cX8ZeoT8ZfuzyL/sJcU+geHB+ctVucvo9c7/lP5qeM/XZ/4+C/Zn0X+0+cEfGEf9n77qTp/Gb0Ofzq/mL9MfSL+0v1pjP8JabUf8wsvFvzkL1bGP6XXHf/i" ..
"/PT4p+qjxr9Ufxb5tzdE9i/3jBxV/jJ6Hf50fjF/mfpE/KX7szz+95R6e3jBd86b/cCLePzTer3xT+Wnxj9dn3j8S/Znmf9rr/e08Pz9HmvnX1qvx5/KT/Gn6xPzl+xP6/pHbQI8+vpHYgLM12i/t4axugMu94aS" ..
"tm8W5cY3wON/X8fYuYOJF6D3PN7ek7svf8VYTbnRRtrOMla1m796Zm74t564+e+FPwWg9VOz/AOJj7revEp++4lr0J98qb2BsfYfIv/mzzerrTBDdO4gX/3OmPwEeELaUGeowt/K63X40/nF/Gm9mL9Kf1b4f7mN" ..
"sdvnj29vrmbBq1+r85fR6/Cn84v503oxf5X+rPCv2MhYS+2xbRePDA92XlPnL6PX4U/nF/On9WL+Kv1Z4R8m2nmNb9Xst/FE/GX0Ovzp/GL+tF7MX6U/K/yfmcsfqXG58nLlD8e3rlbnL6PX4U/nF/On9WL+Kv1Z" ..
"G/+pmfwpop3Xaj769tDqIvXxT+v1xj+Vnxr/lJ4a//L9WeHf3jDQwffu5cq+NsaM17mI+MvodfjT+cX8ab2Yv0p/Vvgvez043Nd6uqzhy4DPU69+/JHR6/Cn84v503oxf5X+rPBPSeu+4R+s3ne6zD8w0G5856yI" ..
"v4xehz+dX8yf1ov5q/Rn9fpHbQI8+vpHegLscucuTQnN7fnTvmK/5o7G85alpI2+AA3jaP5PwBt9eHfUa/kK8JsRNFOypmbxXRJ5DDetP7QltLsG+ArysPe2hi45z8hvP3EHuNzb1jLm7Y386/SHoX/1zJgfjU9M" ..
"L3931sLI7nq7aGK6ygT4c75O3v/MXHm9Dn86v5g/rRfzV+tPnX/bue7m8OdNjaeGBxO/+aH5y+h1+NP5xfxpvZi/Wn/q/KdmrS0Ovzr/GWPGP4Mu4i+j1+FP5xfzp/Vi/mr9qfPnzu+84ZdXchPgeP4yeh3+dH4x" ..
"f1ov5q/Wnzp/PsGjfjJCxF9Gr8Ofzi/mT+vF/NX6szL++c+CfHPI+MgmM/5pvd74p/JT45/SU+NfpT91/sX5kUl1b2t3szp/Gb0Ofzq/mD+tF/NX60+d/4kdjIUnQ98eYsx4kbuIv4xehz+dX8yf1ov5q/Wnzn/m" ..
"Lxk7/eFIH+WM7Vinyl9Gr8Ofzi/mT+vF/NX6s3b9ozYBHn39Q0yAfzabPxb79vmi/Ih7vo89QEfjK94YfaftuU+CgfC0k4My+hJ8xnz/YGjG31BakprJPzFYnsefJRbJT+mfnce/+G89G/ls7cmX6vYzFgwW54eH" ..
"Ar39+P7eWlGx0VPPF0xE4o/N7LvFv9bfUxr+z6cg785Fxm7GXWKJJnjTsgN+xg5uKsovzt/2+4tHWHD0CnSRXo8/nT+Rf96yWP6UnuKv2p8q/6deDt/dMTG9+8Y9jyz/aHe0Xo8/nV/Mn9JT/FX7szb+p8/ZvGqw" ..
"o7NRnT+tT8b4F+WXGf/mernxL9+fOv+nZ/v6Oq9+9Q+zCR7Fn9Lr8qfyU/zFepq/Wn+q/PkEr/1Sc03LmSPvGU8yxPxpvR5/Or+YP6Wn+Kv2p8p/UoZ/sKvx6dkbSqbPkT//RunRej3+dH4xf0pP8Vftz9rxn196" ..
"m91XJ3P8F+mTcfwX5Zc5/pvr5Y7/8v2p8t+6mrHPt05Ie2LWnfP3/qvOn9br8afzi/lTeoq/an+q/GctDH8r63Lvfcf4m0oxf1qvx5/OL+ZP6Sn+qv1ZPf6Yu9zxx3QCnLuUPzR6tEVShOLRdeMsGEicmTediszl" ..
"d65nrLTEaDOfbuFFcbm3h/9oMbfIwUKsX1v8f2XI+CdtM+aH73fkFl7wTG0/vv6IBXwlhdH3FC739ob/7usN5w8Gd/9BboI4a+Fofo1f/zhddoKqy5+egIr5i/WJ/J+dF+Vf+7Fkf0ngPymj5Qxjxz6Q4990amJ6" ..
"4mWKmT45/M3zy/E308vyF/anzX/Lav63oU6jB03I8Bfpk8FflF+Gv7lejj/Rnyb/H44Hg0X5lduNJ3g0f7Fen784P81fpJfhT/anxf+JWSMLxgYHOxJ/rEGOP6XX5U/lp/iL9TR/if60+OcuDV0sXeCXcEG/0ZM9" ..
"Kf6UXpc/lZ/iL9bT/CX6S8L51+Wu/djq8UesT8751zy/3PnXTC97/hX2p8mf32Tm7Q0O+/tXvGGFv1ivz1+cn+Yv0svwJ/vT4p+S1tfq69+/6eRufpc9fxKyGn9Kr8ufyk/xF+tp/hL9JeX4Y+ayxx/TCfC07PAt" ..
"zGY7ID7e70m8zb/pdOwE9I+/Nt5QacmdC1EQnVc/+lOkRLF+1kK+tG3k8rKLD+/JmXevhHfJ8ODx7TLbT+wvGLznaTr12uuJlxEXDocfZcOt7WxkWSM9wZuW3R3NH/T3tzfsKVWZoOryl5kAi/iL9Yn8J2Uk8lft" ..
"zwr/adn8AfDG9wmM5l9WOvo9Ir0+f1F+Gf7mejn+Kv1Z4f/YzENbQtOMQHP16AOLDH+xXp+/KL8Mf3O9HH+V/lT5/6aQBS8cdrnNJngUf1qvx5/KT/EX62n+qv2pj/+y0tKSiekpafVfMBb74C7Z8U/pdce/OD89" ..
"/kV6mfGv1p8q/02r+F+aq/f+6e6lYDD26aFy/Gm9Hn8qP8VfrKf5q/Zn7fqHP6rGeIGvzPFfrE/G9Y95frnrHzO97PWPfH+q/FMz275hbLAj4AsGyt9V50/r9fhT+Sn+Yj3NX7U/9fFflD/QMfLX0DVWzT718U/p" ..
"dce/OD89/kV6mfGv1p/V44+Zyx5/TCfAuv7NoeBw+AHYfAnygsXm73xs5sqCzauK8uO/xpfX626f8tTMksLNqwryjB6QT00wKdfVJyO/MX/n9GfGf/ZCftdBVZnVvLr6ZOU34++U/kTjn/snf9F7Wp+uXje/aPw7" ..
"oT9j/vyjjb62riZ+kmk7a/yMA5Hr6pOX35i/c/qjxn9BHmOf/dV6fl29bn5q/I93f8b8V7zBHzLHX5UUMnZyl2pWXX3y8hvzd05/ovFflK93htHVJyO/aPw7oT9j/l+8z9i2tSlpU7MaqwL+KVmqWXX1yctvzN85" ..
"/ZmP/ylZ61fmLj25m2/JSmZdfXLym49/Z/RHnX9tcf0U+zcxtvEt/up6dcCnfgEy3no5fxAmwPdnf+uKfb1BP/9s76mX/75u7PVOr8/u/qK+Yx1j5p/x2q93en329Hf5q86r3PlPvd08o35809U7vT67+5ucGbnX" ..
"74M1jO3aMNZ6p9dnd39TsoaHum/wVzlLGPvXP8Za7/T67O4v7GcPitZ32K93en329dfwZdCfOvIAoyN/Y8xskbF9eqfXZ3d/EV/zZsDXdV30qDl79U6vz+7+bPJknAAG2oe6jm///hhjdfvvPz3lxfkXDtcfZay7" ..
"pf5obYX02vKk6Z1en739PTuP37PQ1VR/tP6o5yJjks92S5re6fXZ3Z/L3VzdXP351oObqvcNdfv6jX/mwU690+uzu7+wn9jZfinysInx0Du9Pvv662rsaancvn9TzT5vz1D3tOyx1ju9Prv7c7n5mb3hn59u6bjC" ..
"TJcY26l3en1298f9nqf7+njqnV6fff2Vv8t/4urEzu8+8/V7e1Izx1rv9Prs7u/xF2srTuy4+q9gYKizcPnY651en9392ezJSLJ+5VAXX4DdenZq1v2oF3vl9uhN1v7+2Id1j43e6fXZ29/shfF3RryQM7Z6p9dn" ..
"d38ud/W+yL0Zva3rV4693un12d0f9x+n8x+zZ+yeZ1LGeOidXp+d/ZVv9PaE9293i9kdtnbqnV6f3f3x59u3/Cf84JQv3h8PvdPrs7s/l/uR5/pu6Sxu19U7vT57+6v9OHyG6WuL/tTLWOqdXp+9/WXk8AfMMea5" ..
"+ItXxkPv9Prs7s9mT9YpIHepTvvjrYfD4Waempm7tDj/+QVWl7fo6p1en939wcfXH3luweKifLMfmbFf7/T67O6Pe/ary/MefWH89E6vz+7+4OPpU7Pyls38pfXzi67e6fXZ29/kzOV5OrMLXb3T67O7P1sdBxc4" ..
"HA6Hw+FwOBwOhz8UDgRwOBwOh8PhcDgcDn8oHAjgcDgcDofD4XA4HP4w+P8AQEuXMXpD8/kAAAAASUVORK5CYII="

local axis_1 = "image/png;base64," ..
"iVBORw0KGgoAAAANSUhEUgAAB4AAAAAwCAQAAABaxq+2AAAACXBIWXMAAA7EAAAOxAGVKw4bAAATVklEQVR42u2df0xUZ7rHJ+EPkiabbGJiYkLSmJg0aTYxTTZNmiYb09ykZjO0QLHY+quy9Qe1YgG5Re62rlev" ..
"etluXVevt62rrkq1FLG21epW7FqUZRFtq1LqLxAR1FnkNwIzw8x752V27gzDOe/zvuedA0f5fp9kd+SZ7zPv8zlvz5x35pwzLhcEQRAEQRAEQRAEQRAEQRAEQRAEQRAEQRAEQRAEQRAEQRAEQRAEQRAEQRAEQRAE" ..
"QRAEQRAEQRAEQRAEQRAEQRAEQRBkq1gyK2F3Q1HCkpFHHnnkkUceeeSRRx555JFH/lHNu0KJiEqQRx555JFHHnnkkUceeeSRR/4RyzMIgiAIgiAIgiAImgTCAhiCIAiCIAiCIAiaFHK53JGoq4j8sa4i+lfkkUce" ..
"eeSRRx555JFHHnnkkX8k8tGHU9PrKgY7BjvqKqamGxVAHnnkkUceeeSRRx555JFHHvmHOG/0VAQCgUAgEAgEAoFAIB65AAIEAoFAIBAIBAKBQEyKAAIEAoFAIBAIBAKBQEyKGN+Xm5mV+tqUNP7oqblOxPHsvOcW" ..
"JKc+upsb/MEf/MEf/MEf/MEf/MEf/MF/EvN3uX/5Skttd3P3rfh47IXwU8zyR3eovFBy6omP+j0jN+EKdt64WsnYB+tlvbPmt52PjKDzxoxM1Y0+avw3W86d3ju2xs9ePL134D4f3rC38czpvZ767OVy9UfxafZc" ..
"rqv49Wsq4wN/8Ad/8Ad/8Ad/8Ad/8Ad/8Af/ceHvci97w/gXkn72YvgpZvnqA/Iv88yr7T/F+6tKZd3FBbG+z7erbQCj8Q/cHw1p9qL71+Kfc3KXXP383Hinr2/PJr3xgT/4gz/4gz/4gz/4gz/4gz/4g3/C+fP/" ..
"eWf17XOMdVwr3xKOs6WxG2BsvnxLV5PaBmisCq3sh6r2F+bNXrS5uKYsGFDzbygq2/LPhnB7XU1qG2D0+A9tPfvxYAdjzTWxz7hdx1jAV7U/P/f5hVvX3vlhZILsl68f9DNWW8ar15b1tYbMwXdWWxsf+IM/+IM/" ..
"+IM/+IM/+IM/+IM/+NvEP/x/deWM3azmj5582eVemhOqMBx7LnY0P33ky+vmvzN2eq/sALf9jg/pP/89+pcrlaqfJEzL8PUy1niGo3m3UHUTRMfP44/vMubrj2Z3b+Tj27Qm8u+k1K6bjFXukq8f8DEW6W965p3v" ..
"+TSJnMKgNj7wB3/wB3/wB3/wB3/wB3/wB3/wt4n/6AFuKAr4qg9OTb9/9cfjRg2sf3vYW/OJy33ojz0tq3Jlh8c/f2g8E/uXWfMPvDctQwVh2fv87PCn5nI017/R2wBV+xnrbY1mm0KbtfHb2Ofv3dxxLWeFtQ3g" ..
"cme9HhxmbP3b6uNT4V+wCvzBH/zBH/zBH/zBH/zBH/zBH/wV+EcH2NtaV87Xzm3njRuI5G/Xqbbf3czY8Q9VXaODn8N+pdLlPrqDf1n+zKvqG4CPv678hy88l/nnDQfeixlfaKN+pTW+0RsgVPGWWsfgD/7gD/7g" ..
"D/7gD/7gD/7gD/7gbzv/6AAjartg3IAo/9gLC5aaQ3ngYSxyWfKTLy9elr08e/niZb/IkvW73Cvf5K+8Jp/7hwcZO7VH5fVHjz98EXZ+zPfX/THjM4uk1Kdfkd8A/Jz2s6Xyfl3+4vo0f2p8FH+V/qzwn5KWvXz0" ..
"eNX4U35d/uL6NH9qfBR/lf6s8H/8paU5/7bQOn/Kr8tfXJ/mT42P4q/Sn7X9j9obwNj9D/0Gpbf/EYXM/kcc9P5Hvj/wfzj5p2S8nsNPELTKX+RPBH/z+nL8ReOT4S/bH+b/wzf/+fHtr+ZZ50/5E3H8b15f7vhf" ..
"ND6Z43/Z/qzN/9TXspebn1RLz3+xX3/+i+rLzH/x+Oj5L9+fw/Y/0QEOtDdWdTWafwJhnl9XONDO22r+++MvGb1I/x3GSkv4o/xcfvn1vxQszJPzu9yXj/Gz4m9W8/B2M9Z/N/YMedo/Mv773N1c7akPeBkLeKNf" ..
"kfffZezj35sh+kXWke1NZ7zd9cflN8C9i6FJslver8Ofri/mLzM+EX/p/izyT0qt+YQ7+EkUZr9eJuIv49fhT9cX85cZn4i/dH8W+adk/HiC82Ws8/qCper8Zfw6/On6Yv4y4xPxl+7PIv9wFBf4B4cHFy5T5y/j" ..
"19v/U/Wp/T89PvH+X7I/i/xnzQ/4wjHs/f5zdf4yfh3+dH0xf5nxifhL96cx/5NTaz/lB14s+NmfrMx/yq87/8X16flPjY+a/1L9WeTf3hDZvjzSs1X5y/h1+NP1xfxlxifiL92f5fm/v8Tbwwd876LZD7yI5z/t" ..
"15v/VH1q/tPjE89/yf4s83/jzZ4WXr/fY+39l/br8afqU/zp8Yn5S/andfyjtgAee/wjsQDm52h/sJ6xugqXe3Nx23dLc0Y3wPN/3sjYhcPxB6APPN7e0/uufsNYTZnRi7SdZ6xqH3/03ILwbz1x+R+EPwWg/TMy" ..
"/QPxt7retlb+9ePPQX/6lfYGxtp/ivyb39+sttwM0YXD/Ox3xuQXwMmpQ52hEf5O3q/Dn64v5k/7xfxV+rPC/+udjN29eHJXczULXv9Wnb+MX4c/XV/Mn/aL+av0Z4V/+RbGWmpP7Lx8bHiw84Y6fxm/Dn+6vpg/" ..
"7RfzV+nPCv8w0c4b/FXNfhtPxF/Gr8Ofri/mT/vF/FX6s8L/uQX8lhpXK69W/nRyxzp1/jJ+Hf50fTF/2i/mr9KftfmfksHvItp5o+aT74+sK1Sf/7Rfb/5T9an5T/mp+S/fnxX+7Q0DHXzrXq3sa2PM+DwXEX8Z" ..
"vw5/ur6YP+0X81fpzwr/lW8Gh/taz5Y2fB3weerV9z8yfh3+dH0xf9ov5q/SnxX+Sandt/yD1QfPlvoHBtqNr5wV8Zfx6/Cn64v5034xf5X+rB7/qC2Axx7/SC+AXe6cFUmhtT2/21fs19zRfO7KpNSxB6BhHM3/" ..
"CHijN++ORi0/A/x2BM30zBmZfJNEbsNN+49sD22uAX4GeTh6W0OHnOfkXz9+A7jcOzcw5u2N/Ovsx6F/9cxeFM1PSSt7f+6SyOZ6t3BKmsoC+Et+nrz/uQXyfh3+dH0xf9ov5q/Wnzr/tgvdzeHPmxrPDA/Gf/ND" ..
"85fx6/Cn64v5034xf7X+1PnPyNxQFH508QvGjH8GXcRfxq/Dn64v5k/7xfzV+lPnz4NfecMPr+QWwKP5y/h1+NP1xfxpv5i/Wn/q/PkCj/rJCBF/Gb8Of7q+mD/tF/NX68/K/Oc/C/LdEeM9m8z8p/1685+qT81/" ..
"yk/Nf5X+1PkX5UUW1b2t3c3q/GX8Ovzp+mL+tF/MX60/df6ndjMWXgx9f4Qx45PcRfxl/Dr86fpi/rRfzF+tP3X+c37D2NmPR/ooY2z3RlX+Mn4d/nR9MX/aL+av1p+14x+1BfDY4x9iAfyrefy22HcvFuZFwvNj" ..
"7A46ml/91tgrbS98FgyEl50clNGX4LMX+QdDK/6GkuKUDP6Jwapcfi+xSH3K//xC/sV/6/nIZ2tPv1J3iLFgsCgvPBXo1x/d3zury7d46vkJE5H8E3P67vCv9feXhP/zyc+9d5mx26MOsUQLvJlZAT9jh7cW5hXl" ..
"7fyvy8dYcOwZ6CK/Hn+6fjz/3JWx/Ck/xV+1P1X+z7wavrpjSlr3rQceWf7R7mi/Hn+6vpg/5af4q/Znbf7Pmr9t7WBHZ6M6f9qfiPkvqi8z/839cvNfvj91/s/O8/V1Xv/mL2YLPIo/5dflT9Wn+Iv9NH+1/lT5" ..
"8wVe+5XmmpZzxz4wXmSI+dN+Pf50fTF/yk/xV+1Plf/UdP9gV+Oz8zYXz5ov//4bpUf79fjT9cX8KT/FX7U/a/t/fuhtdl2dzP5f5E/E/l9UX2b/b+6X2//L96fKf8c6xr7ckZz61Nx7Fx/8U50/7dfjT9cX86f8" ..
"FH/V/lT5z10S/lbW5T7wnvE3lWL+tF+PP11fzJ/yU/xV+7O6/zEPuf2P6QI4ZwW/afRYRUqE8tHzxlkwEL8ybzoTWcvv2cRYSbHRy3y+nQ+K2709/EeLuSI7C7F/Q9G/nCHxT9pmLwpf78gVPuGZev3R448o4Csu" ..
"iD6nYJW3N/x3X2+4fjC477/lFohzl4zl1/jtz9NkF6i6/OkFqJi/2B/P//mFUf61n0r2lwD+U9NbzjF24iM5/k1npqTFH6aY+RPD37y+HH8zvyx/YX/a/Lev438b6jS60YQMf5E/EfxF9WX4m/vl+BP9afL/6WQw" ..
"WJhXuct4gUfzF/v1+Yvr0/xFfhn+ZH9a/J+aO3LC2OBgR/yPNcjxp/y6/Kn6FH+xn+Yv0Z8W/5wVoYOlS/wQLug3urMnxZ/y6/Kn6lP8xX6av0R/CXj/dblrP7W6/xH7E/P+a15f7v3XzC/7/ivsT5M/v8jM2xsc" ..
"9vevfssKf7Ffn7+4Ps1f5JfhT/anxT8pta/V139o6+l9/Cp7fidkNf6UX5c/VZ/iL/bT/CX6S8j+xyxk9z+mC+CZWeFLmM02wOh8vyf+Mv+ms7EL0N//h/ELlRTfuxQF0Xn9kz9Ehij2z13CT20bObzs4tN7Wsb9" ..
"a+FNMjx4cpfM68f3Fww+8DSdeePN+MOIS0fDt7LhajsfOa2RXuDNzOqO1g/6+9sb9peoLFB1+cssgEX8xf54/lPT4/mr9meF/8wsfgN44+sExvIvLRn7HJFfn7+ovgx/c78cf5X+rPB/Ys6R7aFlRqC5euyORYa/" ..
"2K/PX1Rfhr+5X46/Sn+q/H9bwIKXjrrcZgs8ij/t1+NP1af4i/00f9X+1Od/aUlJ8ZS0pNT6rxiLvXGX7Pyn/LrzX1yfnv8iv8z8V+tPlf/WtfwvzdUH/nD/SjAYe/dQOf60X48/VZ/iL/bT/FX7s3b8w29VY3yC" ..
"r8z+X+xPxPGPeX254x8zv+zxj3x/qvxTMtq+Y2ywI+ALBsreV+dP+/X4U/Up/mI/zV+1P/X5X5g30DHy19AxVs1B9flP+XXnv7g+Pf9Ffpn5r9af1f2PWcjuf0wXwLrx3ZHgcPgG2PwU5MXLzJ/5xJw1+dvWFuaN" ..
"/hpf3q/7+lSkZBQXbFubn2t0g3xqgUmFrj8R9Y35O6c/M/7zlvCrDqpKrdbV9Seqvhl/p/Qnmv88PvuT3t36dP269UXz3wn9GfPnH230tXU18TeZtvPG9zgQha4/cfWN+TunP2r+5+cy9sX/WK+v69etT83/ie7P" ..
"mP/qt/hN5vij4gLGTu9VrarrT1x9Y/7O6U80/wvz9N5hdP2JqC+a/07oz5j/Vx8ytnNDUuqMzMaqgH96pmpVXX/i6hvzd05/5vN/euamNTkrTu/jr2Slsq4/MfXN578z+qPef20J/RKHtjK25R3+6GZ1wKd+ADLR" ..
"frl4FBbAD2d/G4t8vUE//2zvmVf/vHH8/U4fn939RWP3RsbMP+O13+/08dnT39VvOq/z4D/1dvuc+v5N1+/08dnd37SMyLV+H61nbO/m8fY7fXx29zc9c3io+xZ/lL2csb/9Zbz9Th+f3f2F4/xh0fkd9vudPj77" ..
"+mv4OuhPGbmB0bH/ZczsJGP7/E4fn939RWL92wFf103Rrebs9Tt9fHb3Z1Mk4g1goH2o6+SuH08wVnfo4fNTUZR36Wj9cca6W+qP15ZLn1ueML/Tx2dvf88v5NcsdDXVH68/7rnMmOS93RLmd/r47O7P5W6ubq7+" ..
"csfhrdUHh7p9/cY/82Cn3+njs7u/cJza034lcrOJifA7fXz29dfV2NNSuevQ1pqD3p6h7plZ4+13+vjs7s/l5u/sDX/9fHvHNWZ6irGdfqePz+7+eDzwdN+cSL/Tx2dff2Xv85+4OrXnhy98/d6elIzx9jt9fHb3" ..
"9+TLteWndl//WzAw1Fmwavz9Th+f3f3ZHIkosmnNUBc/Abv1/IzMh9Evjspd0Yus/f2xN+seH7/Tx2dvf/OWjL4y4qXs8fU7fXx29+dyVx+MXJvR27ppzfj7nT4+u/vj8fM0/mP2jD3wTE2fCL/Tx2dnf2VbvD3h" ..
"7dvdYnaFrZ1+p4/P7v74/e1b/hG+ccpXH06E3+njs7s/l/uxF/ru6Jzcrut3+vjs7a/20/A7TF9b9KdextPv9PHZ2196Nr/BHGOey79+bSL8Th+f3f3ZHIl6C8hZodP+RPsRCIRZpGTkrCjKe3Gx1dNbdP1OH5/d" ..
"/SEmNh57YfGywjyzH5mx3+/08dndH4+s11flPv7SxPmdPj67+0NMZMzIzF055zfW3190/U4fn739TctYlauzutD1O318dvdna2DngkAgEAgEAoFAIBCISRFAgEAgEAgEAoFAIBCISRHRh1PT6yqGOoc66yqMr6NC" ..
"HnnkkUceeeSRRx555JFHHvmHOB99WFcRuZGO8b00kUceeeSRRx555JFHHnnkkUf+Ic4zCIIgCIIgCIIgCJoEwgIYgiAIgiAIgiAImhRyRcVK/v+vJS4DIY888sgjjzzyyCOPPPLII4/8o5B3seTQU+6EooQlI488" ..
"8sgjjzzyyCOPPPLII4/8o5qHIAiCIAiCIAiCIAiCIAiCIAiCIAiCIAiCIAiCIAiCIAiCIAiCIAiCIAiCIAiCIAiCIAiCIAiCIAiCIAiCIAiCIAiCEqf/A/SNfayCCBqGAAAAAElFTkSuQmCC"

local options = require 'mp.options'
local msg     = require 'mp.msg'

options.read_options(opts)
opts.height = math.min(12, math.max(4, opts.height))
opts.height = math.floor(opts.height)

if not opts.forcewindow and mp.get_property('force-window') == "no" then
    return
end

local function get_visualizer(name, quality, vtrack)
    local w, h, fps

    if quality == "verylow" then
        w = 640
        fps = 30
    elseif quality == "low" then
        w = 960
        fps = 30
    elseif quality == "medium" then
        w = 1280
        fps = 60
    elseif quality == "high" then
        w = 1920
        fps = 60
    elseif quality == "veryhigh" then
        w = 2560
        fps = 60
    else
        msg.log("error", "invalid quality")
        return ""
    end

    h = w * opts.height / 16

    if name == "showcqt" then
        local count = math.ceil(w * 180 / 1920 / fps)

        return "[aid1] asplit [ao]," ..
            "afifo, aformat     = channel_layouts = stereo," ..
            "firequalizer       =" ..
                "gain           = '1.4884e8 * f*f*f / (f*f + 424.36) / (f*f + 1.4884e8) / sqrt(f*f + 25122.25)':" ..
                "scale          = linlin:" ..
                "wfunc          = tukey:" ..
                "zero_phase     = on:" ..
                "fft2           = on," ..
            "showcqt            =" ..
                "fps            =" .. fps .. ":" ..
                "size           =" .. w .. "x" .. h .. ":" ..
                "count          =" .. count .. ":" ..
                "csp            = bt709:" ..
                "bar_g          = 2:" ..
                "sono_g         = 4:" ..
                "bar_v          = 9:" ..
                "sono_v         = 17:" ..
                "axisfile       = data\\\\:'" .. axis_0 .. "':" ..
                "font           = 'Nimbus Mono L,Courier New,mono|bold':" ..
                "fontcolor      = 'st(0, (midi(f)-53.5)/12); st(1, 0.5 - 0.5 * cos(PI*ld(0))); r(1-ld(1)) + b(ld(1))':" ..
                "tc             = 0.33:" ..
                "attack         = 0.033:" ..
                "tlength        = 'st(0,0.17); 384*tc / (384 / ld(0) + tc*f /(1-ld(0))) + 384*tc / (tc*f / ld(0) + 384 /(1-ld(0)))'," ..
            "format             = yuv420p [vo]"


    elseif name == "avectorscope" then
        return "[aid1] asplit [ao]," ..
            "afifo," ..
            "aformat            =" ..
                "sample_rates   = 192000," ..
            "avectorscope       =" ..
                "size           =" .. w .. "x" .. h .. ":" ..
                "r              =" .. fps .. "," ..
            "format             = rgb0 [vo]"


    elseif name == "showspectrum" then
        return "[aid1] asplit [ao]," ..
            "afifo," ..
            "showspectrum       =" ..
                "size           =" .. w .. "x" .. h .. ":" ..
                "win_func       = blackman [vo]"


    elseif name == "showcqtbar" then
        local axis_h = math.ceil(w * 12 / 1920) * 4

        return "[aid1] asplit [ao]," ..
            "afifo, aformat     = channel_layouts = stereo," ..
            "firequalizer       =" ..
                "gain           = '1.4884e8 * f*f*f / (f*f + 424.36) / (f*f + 1.4884e8) / sqrt(f*f + 25122.25)':" ..
                "scale          = linlin:" ..
                "wfunc          = tukey:" ..
                "zero_phase     = on:" ..
                "fft2           = on," ..
            "showcqt            =" ..
                "fps            =" .. fps .. ":" ..
                "size           =" .. w .. "x" .. (h + axis_h)/2 .. ":" ..
                "count          = 1:" ..
                "csp            = bt709:" ..
                "bar_g          = 2:" ..
                "sono_g         = 4:" ..
                "bar_v          = 9:" ..
                "sono_v         = 17:" ..
                "sono_h         = 0:" ..
                "axisfile       = data\\\\:'" .. axis_1 .. "':" ..
                "axis_h         =" .. axis_h .. ":" ..
                "font           = 'Nimbus Mono L,Courier New,mono|bold':" ..
                "fontcolor      = 'st(0, (midi(f)-53.5)/12); st(1, 0.5 - 0.5 * cos(PI*ld(0))); r(1-ld(1)) + b(ld(1))':" ..
                "tc             = 0.33:" ..
                "attack         = 0.033:" ..
                "tlength        = 'st(0,0.17); 384*tc / (384 / ld(0) + tc*f /(1-ld(0))) + 384*tc / (tc*f / ld(0) + 384 /(1-ld(0)))'," ..
            "format             = yuv420p," ..
            "split [v0]," ..
            "crop               =" ..
                "h              =" .. (h - axis_h)/2 .. ":" ..
                "y              = 0," ..
            "vflip [v1];" ..
            "[v0][v1] vstack [vo]"


    elseif name == "showwaves" then
        return "[aid1] asplit [ao]," ..
            "afifo," ..
            "showwaves          =" ..
                "size           =" .. w .. "x" .. h .. ":" ..
                "r              =" .. fps .. ":" ..
                "mode           = p2p," ..
            "format             = rgb0 [vo]"
    elseif name == "off" then
        local hasvideo = false
        for id, track in ipairs(mp.get_property_native("track-list")) do
            if track.type == "video" then
                hasvideo = true
                break
            end
        end
        if hasvideo then
            return "[aid1] asetpts=PTS [ao]; [vid1] setpts=PTS [vo]"
        else
            return "[aid1] asetpts=PTS [ao];" ..
                "color      =" ..
                    "c      = Black:" ..
                    "s      =" .. w .. "x" .. h .. "," ..
                "format     = yuv420p [vo]"
        end
    end

    msg.log("error", "invalid visualizer name")
    return ""
end

local function select_visualizer(vtrack)
    if opts.mode == "off" then
        return ""
    elseif opts.mode == "force" then
        return get_visualizer(opts.name, opts.quality, vtrack)
    elseif opts.mode == "noalbumart" then
        if vtrack == nil then
            return get_visualizer(opts.name, opts.quality, vtrack)
        end
        return ""
    elseif opts.mode == "novideo" then
        if vtrack == nil or vtrack.albumart then
            return get_visualizer(opts.name, opts.quality, vtrack)
        end
        return ""
    end

    msg.log("error", "invalid mode")
    return ""
end

local function visualizer_hook()
    local count = mp.get_property_number("track-list/count", -1)
    if count <= 0 then
        return
    end

    local atrack = mp.get_property_native("current-tracks/audio")
    local vtrack = mp.get_property_native("current-tracks/video")

    --no tracks selected (yet)
    if atrack == nil and vtrack == nil then
        for id, track in ipairs(mp.get_property_native("track-list")) do
            if track.type == "video" and (vtrack == nil or vtrack.albumart == true) and mp.get_property("vid") ~= "no" then
                vtrack = track
            elseif track.type == "audio" then
                atrack = track
            end
        end
    end

    local lavfi = select_visualizer(vtrack)
    --prevent endless loop
    if lavfi ~= mp.get_property("options/lavfi-complex", "") then
        mp.set_property("options/lavfi-complex", lavfi)
    end
end

mp.add_hook("on_preloaded", 50, visualizer_hook)
mp.observe_property("current-tracks/audio", "native", visualizer_hook)
mp.observe_property("current-tracks/video", "native", visualizer_hook)

local function cycle_visualizer()
    local i, index = 1
    for i = 1, #visualizer_name_list do
        if (visualizer_name_list[i] == opts.name) then
            index = i + 1
            if index > #visualizer_name_list then
                index = 1
            end
            break
        end
    end
    opts.name = visualizer_name_list[index]
    visualizer_hook()
end

mp.add_key_binding(cycle_key, "cycle-visualizer", cycle_visualizer)
