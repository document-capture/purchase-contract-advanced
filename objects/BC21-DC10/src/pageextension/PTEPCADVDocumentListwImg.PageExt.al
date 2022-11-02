pageextension 61140 "PTE PCADV Document List w Img" extends "CDC Document List With Image"
{
    actions
    {
        addafter("Create Purchase Contract")
        {
            action(ShowContract)
            {
                ApplicationArea = All;
                Image = Navigate;
                Enabled = IsLinkedToPurchaseContract;
                Caption = 'Contract Card';
                ToolTip = 'Opens the purchase contract card, if the document is linked to a contract';
                Promoted = true;
                PromotedCategory = Category4;
                PromotedIsBig = true;

                trigger OnAction()
                var
                    PurchContractHeaderCard: Page "CDC Purch. Contract Card";
                begin
                    PurchContractHeaderCard.SetRecord(PurchaseContractHeader);
                    PurchContractHeaderCard.Run();
                end;
            }
        }
    }

    trigger OnAfterGetCurrRecord()
    var

    begin
        IsLinkedToPurchaseContract := PurchaseContractExists(Rec);
    end;

    local procedure PurchaseContractExists(var Document: Record "CDC Document"): Boolean
    var
        DocumentCategory: Record "CDC Document Category";
        Template: Record "CDC Template";
        DocNoTemplateField: Record "CDC Template Field";
        DocTypeTemplateField: Record "CDC Template Field";
        DocumentValue: Record "CDC Document Value";
        CaptureMgt: Codeunit "CDC Capture Management";
    begin
        // Make sure we only proceed on purch. invoice documents >>>
        if not Template.Get(Rec."Template No.") then
            exit;

        if not DocumentCategory.Get(Template."Category Code") then
            exit;

        if not ((DocumentCategory."Source Table No." = 23) and (DocumentCategory."Destination Header Table No." = 38)) then
            exit;
        // Make sure we only proceed on purch. invoice documents <<<

        if not DocTypeTemplateField.GET(Rec."Template No.", DocTypeTemplateField.Type::Header, 'ACCOUNTTYPE') then
            exit;

        if not CaptureMgt.GetFieldValue(Rec, DocTypeTemplateField, 0, DocumentValue) then
            exit;

        if DocumentValue."Value (Text)" <> '8' then
            exit;

        if not DocNoTemplateField.GET(Rec."Template No.", DocNoTemplateField.Type::Header, 'GLACCOUNTNO') then
            exit;

        if not CaptureMgt.GetFieldValue(Rec, DocNoTemplateField, 0, DocumentValue) then
            exit;

        exit(PurchaseContractHeader.get(DocumentValue."Value (Text)"));
    end;

    var
        [InDataSet]
        IsLinkedToPurchaseContract: Boolean;
        PurchaseContractHeader: Record "CDC Purch. Contract Header";
}
