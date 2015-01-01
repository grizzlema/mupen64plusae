/* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *
 *   Copyright (C) 2011 yongzh (freeman.yong@gmail.com)                    *
 *                                                                         *
 *   This program is free software; you can redistribute it and/or modify  *
 *   it under the terms of the GNU General Public License as published by  *
 *   the Free Software Foundation; either version 2 of the License, or     *
 *   (at your option) any later version.                                   *
 *                                                                         *
 *   This program is distributed in the hope that it will be useful,       *
 *   but WITHOUT ANY WARRANTY; without even the implied warranty of        *
 *   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the         *
 *   GNU General Public License for more details.                          *
 *                                                                         *
 *   You should have received a copy of the GNU General Public License     *
 *   along with this program; if not, write to the                         *
 *   Free Software Foundation, Inc.,                                       *
 *   51 Franklin Street, Fifth Floor, Boston, MA 02110-1301, USA.          *
 * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * */

#ifndef FRAME_SKIPPER_H
#define FRAME_SKIPPER_H

class FrameSkipper
{
public:
  enum { AUTO, MANUAL };

  FrameSkipper();

  void setSkips(int type, int max) { _skipType = type; _maxSkips = max; }

  void setTargetFPS(int fps) { _targetFPS = fps; }

  bool willSkipNext() { return (_skipCounter > 0); }

  void update();

private:
  unsigned int getCurrentTicks();

  int _skipType;
  int _maxSkips;
  int _targetFPS;
  int _skipCounter;
  unsigned int _initialTicks;
  unsigned int _actualFrame;
};

#endif

