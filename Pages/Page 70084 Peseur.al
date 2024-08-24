page 70084 Peseur
{
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Lists;
    SourceTable = Peseur;
    DataCaptionFields = "Team Code";

    layout
    {
        area(Content)
        {
            repeater(Control1)
            {

                field("Code peseur"; rec."Code peseur")
                {

                }
                field("Team Name"; rec."Team Name") { }
            }
        }
        area(Factboxes)
        {

        }
    }

    actions
    {
        area(Processing)
        {
            action(ActionName)
            {
                ApplicationArea = All;

                trigger OnAction();
                begin

                end;
            }
        }
    }
}