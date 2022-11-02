page 61140 "PTE PCADV Template List"
{
    ApplicationArea = All;
    Caption = 'PTE PCADV Template List';
    PageType = List;
    SourceTable = "PTE PCADV Contr. Templ. Header";
    UsageCategory = Lists;

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field("Template Code"; Rec."Template Code")
                {
                    ToolTip = 'Specifies the value of the Template Code field.';
                }
                field("Template Description"; Rec."Template Description")
                {
                    ToolTip = 'Specifies the value of the Template Description field.';
                }
                field(Description; Rec.Description)
                {
                    ToolTip = 'Specifies the value of the Description field.';
                }
                field("Purchaser Code"; Rec."Purchaser Code")
                {
                    ToolTip = 'Specifies the value of the Purchaser Code (Reviewer) field.';
                }
                field("Cost Category Code"; Rec."Cost Category Code")
                {
                    ToolTip = 'Specifies the value of the Cost Category Code field.';
                }
                field("Price Period Code"; Rec."Price Period Code")
                {
                    ToolTip = 'Specifies the value of the Invoicing Period Code field.';
                }
                field(Review; Rec.Review)
                {
                    ToolTip = 'Specifies the value of the Review field.';
                }
                field("Review Dateformula"; Rec."Review Dateformula")
                {
                    ToolTip = 'Specifies the value of the Review Date Formula field.';
                }
                field("Contract Line Type"; Rec."Contract Line Type")
                {
                    ToolTip = 'Specifies the value of the Contract Line Type field.';
                }
                field("Contract Line No."; Rec."Contract Line No.")
                {
                    ToolTip = 'Specifies the value of the Contract Line No. field.';
                }
            }
        }
    }
}
