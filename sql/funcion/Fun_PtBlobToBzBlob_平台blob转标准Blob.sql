create or replace function Fun_PtBlobToBzBlob( i_PtBlob IN  BLOB)
  return blob IS
  o_BzBlob blob;       --���ر�׼��BLOB
  v_nWjcd  INTEGER;    --�ļ�������
  v_nWjzcd INTEGER;    --�ļ��ܳ���
  v_nJqcd  INTEGER;    --��ȡ�ļ�����
  v_nJqkswz INTEGER;   --��ȡ��ʼλ��
  
  --ƽ̨blobת��Ϊ��שblob
BEGIN
  IF i_PtBlob IS NULL THEN
    RETURN NULL;
  END IF;
  --���ļ������ȴ�16����תΪ10����
  v_nWjcd:=to_number(dbms_lob.substr(i_PtBlob,1,1),'xx');
  --���ļ������ֽڳ���
  v_nWjzcd:=dbms_lob.getlength(i_PtBlob);
  v_nJqcd:=v_nWjzcd-v_nWjcd-1;
  v_nJqkswz:=v_nWjcd+2;

  dbms_lob.createtemporary(o_BzBlob,TRUE);
  DBMS_LOB.Copy(o_BzBlob,i_PtBlob,v_nJqcd,1,v_nJqkswz);

  return(o_BzBlob);
  exception when others then
   return null;
end fun_PtBlobToBzBlob;
