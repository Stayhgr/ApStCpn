create or replace function Fun_PtBlobToBzBlob( i_PtBlob IN  BLOB)
  return blob IS
  o_BzBlob blob;       --返回标准的BLOB
  v_nWjcd  INTEGER;    --文件名长度
  v_nWjzcd INTEGER;    --文件总长度
  v_nJqcd  INTEGER;    --截取文件长度
  v_nJqkswz INTEGER;   --截取开始位置
  
  --平台blob转换为标砖blob
BEGIN
  IF i_PtBlob IS NULL THEN
    RETURN NULL;
  END IF;
  --将文件名长度从16进制转为10进制
  v_nWjcd:=to_number(dbms_lob.substr(i_PtBlob,1,1),'xx');
  --获文件的总字节长度
  v_nWjzcd:=dbms_lob.getlength(i_PtBlob);
  v_nJqcd:=v_nWjzcd-v_nWjcd-1;
  v_nJqkswz:=v_nWjcd+2;

  dbms_lob.createtemporary(o_BzBlob,TRUE);
  DBMS_LOB.Copy(o_BzBlob,i_PtBlob,v_nJqcd,1,v_nJqkswz);

  return(o_BzBlob);
  exception when others then
   return null;
end fun_PtBlobToBzBlob;
