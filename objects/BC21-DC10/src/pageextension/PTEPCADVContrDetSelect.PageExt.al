pageextension 61141 "PTE PCADV Contr. Det. Select" extends "CDC Purch. Contr. Det. Select"
{
    layout
    {
        addbefore(Description)
        {
            field(ContractTemplate; ContractTemplate)
            {
                ApplicationArea = All;
                Caption = 'Contract Template';

                trigger OnLookup(var Text: Text): Boolean
                var
                    ContractTemplateHeader: Record "PTE PCADV Contr. Templ. Header";
                    ContractTemplateList: Page "PTE PCADV Template List";
                begin
                    ContractTemplateList.LookupMode := true;
                    if ContractTemplateList.RunModal() = Action::LookupOK then begin
                        ContractTemplateList.GetRecord(ContractTemplateHeader);
                        ContractTemplate := ContractTemplateHeader."Template Code";
                        PrefillFieldsFromTemplate(ContractTemplateHeader);
                    end

                end;
            }
        }
    }

    local procedure PrefillFieldsFromTemplate(ContractTemplateHeader: Record "PTE PCADV Contr. Templ. Header")
    var

    begin
        Rec.TransferFields(ContractTemplateHeader, false);
    end;

    var
        ContractTemplate: Code[20];
}
