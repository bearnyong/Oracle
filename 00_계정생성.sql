-- �� �� �ּ�
/* ���� �� �ּ� */

/* ���� ������ ���� ��ɾ�� ������ ������ �Ѵ�.*/

-- [���� ����]
-- CREATE USER C##EMPLOYEE IDENTIFIED BY EMPLOYEE;
-- C##EMPLOYEE��� ������ �߰��ϰ� ��й�ȣ�� EMPLOYEE�� �ϰڴ�.
-- C##�� �پ��ִ� ����? CDB�� �ĺ����ֱ� ���ؼ�? (����Ŭ Ư��)

-- [���� ����]
-- GRANT RESOURCE, CONNECT TO C##EMPLOYEE;
-- �ش� ����ڰ� �����ͺ��̽��� ������ �� �ִ� ������ �ֱ� ���� CONNECT�� �ۼ��Ѵ�.
-- �ε���, ��, Ʈ���� ���� �����ͺ��̽� �������� ���� �� �ִ� ������ ��Ƴ���.. RESOURCE?

/* F9�� ������ �� ���� ����Ǳ⿡ �ߺ� ������ ���� �ʵ��� �� �پ� ������Ѿ� �Ѵ�.? */

-- [�������� ���� �� �߻��ϴ� �뷮 ����]
-- ALTER USER C##EMPLOYEE QUOTA UNLIMITED ON SYSTEM;
-- ALTER USER C##EMPLOYEE QUOTA UNLIMITED ON USERS;
-- SYSTEM�� USERS�� �뷮 ������ ���ش�.

/* �� �������� DBA �����̱� ������ ���� ��... */
