   M S B A M L   `   `   `  ����]  YBeginningKinect.Chapter5.SimonSays, Version=1.0.0.0, Culture=neutral, PublicKeyToken=nullW0clr-namespace:BeginningKinect.Chapter5.SimonSays"BeginningKinect.Chapter5.SimonSays  5   	   3    -BeginningKinect.Chapter5.SimonSays.MainWindow   5   	   \ XPresentationFramework, Version=4.0.0.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35R NWindowsBase, Version=4.0.0.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35W SPresentationCore, Version=4.0.0.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35D 9http://schemas.microsoft.com/winfx/2006/xaml/presentation    5   	   R NSystem.Xaml, Version=4.0.0.0, Culture=neutral, PublicKeyToken=b77a5c561934e089:x,http://schemas.microsoft.com/winfx/2006/xaml     5   	   >c0clr-namespace:BeginningKinect.Chapter5.SimonSays     5   	     � Title$  
Simon Says��5   	   $
��1080��6   $
��1920��6*    � WindowState$ 	Maximized=�5   	   
�������
���   �.��5
      (� .��5   
   � -   5         �Name$ 
LayoutRoot��5      $
��1080��6#   $
��1920��61   .+�5      �� $��images/background.jpg��6   $
��1080��63   $
��1920��6A   �� 5      $��
Simon Says��6   $��72(�6,   $��0,25,0,0q�6:   $��Center=�6L   $	��Top=�6i   �� 5      $��Center=�6   $��Center=�66   $	��600��6Q   .+�5      �� -   5         ��Name$ GameStateElement��5      $��
GAME OVER!��66   $��55(�6H   $��Center=�6V   �� 5      -   5        $ GameInstructionsElement��5      $7��1Place hands over the targets to start a new game.��6=   $��45(�6v   $��Center=�6�    �� TextAlignment$ Center=�6�   $
��Wrap=�6�   $��0,20,0,0q�6�   5      �� 5      -   5         ��Name$ 
GameCanvas��5      .+�5      �� -   5         ��Name$ RedBlock��5      $	��400��6.   $	��400��6;   
���  �� �� Left$	 170��6R   
 �� Top$ 90��6d   	 J� Opacity$		 0.2Q�6t   �� 5      -   5        $ 	BlueBlock��5      $	��400��6/   $	��400��6<   
����  �$	 170��6T   $	 550��6f   $		 0.2Q�6w   �� 5      -   5        $ 
GreenBlock��5      $	��400��60   $	��400��6=   
��� � �$
 1350��6V   $	 550��6i   $		 0.2Q�6z   �� 5      -   5        $ YellowBlock��5      $	��400��61   $	��400��6>   
��� ���$
 1350��6X   $ 90��6k   $		 0.2Q�6{   5      �� 5      -	   5        $ ControlCanvas��5      .+�5      �� -
   5        
 ��Name$
 RightHandStartElement��5      
���  ��$	��200��6I    �� Padding$ 20q�6V   $
 1420��6c   $	 440��6v   ._�5      �� $��Images/hand.png��6   5       �� 5"      -   5        $
 LeftHandStartElement��5"      
���  ��$	��200��6H   $ 20q�6U   $	 300��6b   $	 440��6t   ._�5#      �� $��Images/hand.png��6   z�5$      V� 5%      .~�5&   "   T�  T� X$
 -130Q�65   �� 5'   "    �� ScaleX$ -1Q�61   5(      5*      5+      5,      7   1BeginningKinect.Chapter5.SimonSays.SkeletonViewer  5.      -   5          Name$ SkeletonViewerElement��5.      �� 5/      -   5        $ 
HandCanvas��5/      .+�50      �� -   5         ��Name$ RightHandElement��50      $��Images/hand.png��62   $y�	Collapsed=�6K   $	��100��6b   $	��100��6o   �� 52      -   5        $ LeftHandElement��52      $��Images/hand.png��61   $y�	Collapsed=�6J   $	��100��6a   $	��100��6n   z�53      V� 54      .~�55      �� $ -1Q�6-   T� 56      $ 90Q�61   57      59      5:      5;      5<      5=      