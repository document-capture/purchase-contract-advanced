table 61140 "PTE PCADV Contr. Templ. Header"
{
    Caption = 'Contract Template Header';
    DataClassification = CustomerContent;
    LookupPageId = 61140;

    fields
    {
        field(1; "Template Code"; Code[20])
        {
            Caption = 'Template Code';
            DataClassification = ToBeClassified;
        }
        field(2; "Template Description"; Text[50])
        {
            Caption = 'Template Description';
            DataClassification = ToBeClassified;
        }

        field(4; "Purchaser Code"; Code[20])
        {
            Caption = 'Purchaser Code (Reviewer)';
            DataClassification = CustomerContent;
            TableRelation = "Salesperson/Purchaser";

            trigger OnValidate()
            var
                PurchaseContract: Record "CDC Purch. Contract Header";
            begin
                CalcReviewerID;
            end;
        }
        field(5; "Cost Category Code"; Code[10])
        {
            Caption = 'Cost Category Code';
            DataClassification = CustomerContent;
            TableRelation = "CDC Contract Category";

            trigger OnValidate()
            var
                ContractCategory: Record "CDC Contract Category";
            begin
            end;
        }

        field(8; "Price Period Code"; Code[10])
        {
            Caption = 'Invoicing Period Code';
            DataClassification = CustomerContent;
            TableRelation = "CDC Price Period".Code;

            trigger OnValidate()
            begin
                IF "Price Period Code" = xRec."Price Period Code" THEN
                    EXIT;
            end;
        }
        field(9; Description; Text[50])
        {
            Caption = 'Description';
            DataClassification = CustomerContent;
        }
        field(20; Review; Option)
        {
            Caption = 'Review';
            DataClassification = CustomerContent;
            InitValue = Yearly;
            OptionCaption = 'Monthly,Yearly,Date Formula';
            OptionMembers = Monthly,Yearly,Dateformula;
        }
        field(21; "Review Dateformula"; DateFormula)
        {
            Caption = 'Review Date Formula';
            DataClassification = CustomerContent;
        }

        field(41; "Reviewer ID"; Code[50])
        {
            Caption = 'Approver ID';
            DataClassification = CustomerContent;
            TableRelation = User."User Name";
            //This property is currently not supported
            //TestTableRelation = false;
        }
        field(1004; "Contract Line Type"; Option)
        {
            Caption = 'Subscription Type';
            DataClassification = CustomerContent;
            OptionMembers = Employee,Resource,Department,Office,"Fixed Asset",Job;
        }
        field(1005; "Contract Line No."; Code[20])
        {
            Caption = 'Subscription No.';
            DataClassification = CustomerContent;
            TableRelation = IF ("Contract Line Type" = CONST(Employee)) Employee
            ELSE
            IF ("Contract Line Type" = CONST(Resource)) Resource
            ELSE
            //IF ("Contract Line Type" = CONST(Department)) "Dimension Value".Code WHERE("Dimension Code" = FIELD("Type Dimension Code"))
            //ELSE
            IF ("Contract Line Type" = CONST(Office)) "CDC Office"
            ELSE
            IF ("Contract Line Type" = CONST("Fixed Asset")) "Fixed Asset"
            ELSE
            IF ("Contract Line Type" = CONST(Job)) Job;
        }
    }
    keys
    {
        key(PK; "Template Code")
        {
            Clustered = true;
        }
    }

    internal procedure CalcReviewerID()
    var
        UserSetup: Record "User Setup";
    begin
        UserSetup.SETRANGE("Salespers./Purch. Code", "Purchaser Code");
        IF UserSetup.FINDFIRST THEN
            Rec."Reviewer ID" := UserSetup."User ID";
    end;
}
