pageextension 70104 "Creation ticket" extends "Creation ticket"
{
    layout
    {
        // Add changes to page layout here
    }

    actions
    {
        addafter(EmbeddingAction)
        {
            action("Creation")
            {
                Caption = 'Tickets pont bascule';
                RunObject = Page Creation_Ticket;
                ApplicationArea = All;
            }
             action("CreateNewMultiPese")
            {
                Visible = false;
                CaptionML = ENU = 'Create New T', FRA = 'Créer nouveau ticket Multipese';
                Image = New;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                

                RunObject = page "Ticket Header";
                
                // RunPageLink=

                // trigger OnAction()
                // var
                //     allRec: Record "Item Weigh Bridge";
                //     NewRec: Record "Item Weigh Bridge" temporary;

                //     balance: Record Balance;
                //     jObj: JsonObject;
                //     jTok: JsonToken;
                // begin
                    
                //     Page.Run(Page::"Ticket Header");
                // end;
            }
            
         
        }
        
            
        
    }

    var
        myInt: Integer;
}