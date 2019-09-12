-----------------------------------------

CREATE OR REPLACE FUNCTION EXPANDADDR (addrid       in number,
                                      showtownarea in number default 1,
                                      b_showprovicearea in char default 'N')
  return char
is
  res         varchar2(4000);
begin
  --rewrited  12.02.2010 by ra
  select substr(trim(trim(',' from trim(
         decode(showtownarea,1,
                        decode(a.regions_id, null, '', r.name)||-- Субъект федерации
                        decode(b_showprovicearea,'Y',nvl2(pa.name,', '||pa.name,''),'')|| -- Область субъекта федерации
                        nvl2(tn.full_name, ', '||replace(tn.full_name, '. ', '.'),'')/*|| -- Город
                        nvl2(ta.name,', '||ta.name||' р-н','') -- Район города*/
                        ,'')||

         nvl2(a.postcode,', '||a.postcode,'') ||  -- индекс
         nvl2(ta.name,', '||ta.name||' р-н','') ||
         nvl2(st.street_name, ', '||replace(trim(t.short_name||' '||st.street_name), '. ', '.'),'')||
         nvl2(a.house, ', д. '||a.house||decode(a.house_char, '', '', '-'||a.house_char),'')||
         nvl2(a.btiliter, ', лит. '||a.btiliter, '')||
         nvl2(a.tank,'/'||a.tank,'')||
         nvl2(a.appartment,', кв. '||a.appartment,'')||

         nvl2(a.room,', помещ. '||a.room,'')||
         nvl2(a.addon,', '||a.addon,'')
         --decode(sign(instr(a.addon, '680')), 1, ', '||a.addon, decode(tn.id, 1, ', '||a.addon ||', 680000', ', '||a.addon))
         ))),1,500)
    into res
    from address a,
         townnames tn,
         townarea     ta,
         streets      st,
         streettypes  t,
         regions r,
         provincearea pa
   where a.townnames_id = tn.id(+)
     and a.townarea_id = ta.id(+)
     and st.street_type_id = t.id(+)
     and a.streets_id = st.id(+)
     and a.regions_id=r.id(+)
     and a.provincearea_id=pa.id(+)
     and a.id=addrid;
  return res;
exception
  when others then begin
    --dbms_output.put_line(addrid);
    return '';
  end;
end;

-----------------------------------------
